import Foundation
import CoreServices

final class LocalFileMonitor {

    static let shared = LocalFileMonitor()

    private var eventStream: FSEventStreamRef?
    private var rebuildTask: Task<Void, Never>?

    private init() {}

    deinit {
        stop()
    }

    func start() {

        stop()

        let fileManager = FileManager.default
        let homeDirectory = fileManager.homeDirectoryForCurrentUser

        let locations: [URL] = [
            homeDirectory.appendingPathComponent("Desktop"),
            homeDirectory.appendingPathComponent("Documents"),
            homeDirectory.appendingPathComponent("Downloads"),
            homeDirectory.appendingPathComponent("Movies"),
            homeDirectory.appendingPathComponent("Music"),
            homeDirectory.appendingPathComponent("Pictures")
        ]

        let paths = locations
            .filter {
                fileManager.fileExists(
                    atPath: $0.path
                )
            }
            .map(\.path) as CFArray

        guard CFArrayGetCount(paths) > 0 else {

#if DEBUG
            print("No local folders available for monitoring.")
#endif

            return
        }

        var context = FSEventStreamContext(
            version: 0,
            info: Unmanaged.passUnretained(self).toOpaque(),
            retain: nil,
            release: nil,
            copyDescription: nil
        )

        let callback: FSEventStreamCallback = {
            _,
            clientCallbackInfo,
            numberOfEvents,
            _,
            _,
            _ in

            guard numberOfEvents > 0,
                  let clientCallbackInfo
            else {
                return
            }

            let monitor =
            Unmanaged<LocalFileMonitor>
                .fromOpaque(clientCallbackInfo)
                .takeUnretainedValue()

            monitor.scheduleRebuild()
        }

        guard let stream = FSEventStreamCreate(
            nil,
            callback,
            &context,
            paths,
            FSEventStreamEventId(kFSEventStreamEventIdSinceNow),
            0.5,
            FSEventStreamCreateFlags(
                kFSEventStreamCreateFlagFileEvents |
                kFSEventStreamCreateFlagNoDefer
            )
        ) else {

#if DEBUG
            print("Failed to create local file event stream.")
#endif

            return
        }

        eventStream = stream

        FSEventStreamSetDispatchQueue(
            stream,
            DispatchQueue.global(
                qos: .utility
            )
        )

        guard FSEventStreamStart(stream) else {

            FSEventStreamInvalidate(stream)
            FSEventStreamRelease(stream)

            eventStream = nil

#if DEBUG
            print("Failed to start local file event stream.")
#endif

            return
        }

#if DEBUG
        print(
            "👀 Monitoring \(CFArrayGetCount(paths)) local folders recursively."
        )
#endif
    }

    func stop() {

        rebuildTask?.cancel()
        rebuildTask = nil

        guard let eventStream else {
            return
        }

        FSEventStreamStop(eventStream)
        FSEventStreamInvalidate(eventStream)
        FSEventStreamRelease(eventStream)

        self.eventStream = nil
    }

    private func scheduleRebuild() {

        rebuildTask?.cancel()

        rebuildTask = Task {

            try? await Task.sleep(
                for: .milliseconds(750)
            )

            guard !Task.isCancelled else {
                return
            }

            await LocalIndexRegistry.shared.rebuild()
        }
    }
}

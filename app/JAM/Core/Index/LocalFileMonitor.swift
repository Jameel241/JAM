import Foundation

final class LocalFileMonitor {

    static let shared = LocalFileMonitor()

    private var sources: [DispatchSourceFileSystemObject] = []
    private var rebuildTask: Task<Void, Never>?

    private init() {}

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

        for location in locations {

            guard fileManager.fileExists(
                atPath: location.path
            ) else {
                continue
            }

            monitor(location)

        }

        print(
            "👀 Monitoring \(sources.count) local folders."
        )

    }

    func stop() {

        rebuildTask?.cancel()
        rebuildTask = nil

        for source in sources {
            source.cancel()
        }

        sources.removeAll()

    }

    private func monitor(_ location: URL) {

        let fileDescriptor = open(
            location.path,
            O_EVTONLY
        )

        guard fileDescriptor >= 0 else {

            print(
                "Failed to monitor:",
                location.path
            )

            return

        }

        let source = DispatchSource.makeFileSystemObjectSource(
            fileDescriptor: fileDescriptor,
            eventMask: [
                .write,
                .delete,
                .rename,
                .extend,
                .attrib,
                .link
            ],
            queue: DispatchQueue.global(
                qos: .utility
            )
        )

        source.setEventHandler { [weak self] in

            self?.scheduleRebuild()

        }

        source.setCancelHandler {

            close(fileDescriptor)

        }

        sources.append(source)

        source.resume()

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

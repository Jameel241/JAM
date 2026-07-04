import SwiftUI
import AppKit

struct JAMScrollEventMonitor: NSViewRepresentable {

    let onScroll: (
        CGFloat,
        Bool,
        NSEvent.Phase
    ) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(onScroll: onScroll)
    }

    func makeNSView(context: Context) -> NSView {

        let view = NSView()

        context.coordinator.startMonitoring()

        return view
    }

    func updateNSView(
        _ nsView: NSView,
        context: Context
    ) {
        context.coordinator.onScroll = onScroll
    }

    static func dismantleNSView(
        _ nsView: NSView,
        coordinator: Coordinator
    ) {
        coordinator.stopMonitoring()
    }

    final class Coordinator {

        var onScroll: (
            CGFloat,
            Bool,
            NSEvent.Phase
        ) -> Void

        private var monitor: Any?

        init(
            onScroll: @escaping (
                CGFloat,
                Bool,
                NSEvent.Phase
            ) -> Void
        ) {
            self.onScroll = onScroll
        }

        func startMonitoring() {

            guard monitor == nil else {
                return
            }

            monitor = NSEvent.addLocalMonitorForEvents(
                matching: .scrollWheel
            ) { [weak self] event in

                self?.onScroll(
                    event.scrollingDeltaY,
                    event.hasPreciseScrollingDeltas,
                    event.phase
                )

                return event
            }
        }

        func stopMonitoring() {

            guard let monitor else {
                return
            }

            NSEvent.removeMonitor(monitor)

            self.monitor = nil
        }

        deinit {
            stopMonitoring()
        }
    }
}

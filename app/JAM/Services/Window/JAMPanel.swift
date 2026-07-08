import AppKit

final class JAMPanel: NSPanel {

    override var canBecomeKey: Bool {
        true
    }

    override var canBecomeMain: Bool {
        false
    }

    convenience init() {

        self.init(
            contentRect: NSRect(
                x: 0,
                y: 0,
                width: WindowConfiguration.command.width,
                height: WindowConfiguration.command.height
            ),
            styleMask: [
                .borderless,
                .fullSizeContentView,
                .nonactivatingPanel
            ],
            backing: .buffered,
            defer: false
        )

        isFloatingPanel = true
        level = .floating

        titleVisibility = .hidden
        titlebarAppearsTransparent = true

        isMovableByWindowBackground = true
        isOpaque = false
        hasShadow = false

        backgroundColor = .clear
        

        collectionBehavior = [
            .canJoinAllSpaces,
            .fullScreenAuxiliary
        ]

        animationBehavior = .utilityWindow
    }
}

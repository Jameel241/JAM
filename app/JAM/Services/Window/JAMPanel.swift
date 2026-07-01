import AppKit

final class JAMPanel: NSPanel {

    override var canBecomeKey: Bool {
        true
    }

    override var canBecomeMain: Bool {
        true
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
                .nonactivatingPanel,
                .fullSizeContentView
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
            .fullScreenAuxiliary,
            .moveToActiveSpace
        ]

        animationBehavior = .utilityWindow

    }

}

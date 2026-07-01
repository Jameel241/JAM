import AppKit
import SwiftUI

final class WindowManager {

    static let shared = WindowManager()

    private lazy var commandPanel: JAMPanel = {

        let panel = JAMPanel()

        let hostingView = NSHostingView(
            rootView: CommandPanelView()
        )

        hostingView.frame = panel.contentView!.bounds
        hostingView.autoresizingMask = [.width, .height]

        panel.contentView?.addSubview(hostingView)

        return panel

    }()

    func showCommandPanel() {

        commandPanel.center()
        commandPanel.makeKeyAndOrderFront(nil)

    }

    func hideCommandPanel() {

        commandPanel.orderOut(nil)

    }

    func toggleCommandPanel() {

        if commandPanel.isVisible {
            hideCommandPanel()
        } else {
            showCommandPanel()
        }

    }

}

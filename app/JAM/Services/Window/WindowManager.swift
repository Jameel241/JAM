import AppKit
import SwiftUI

final class WindowManager {

    static let shared = WindowManager()

    private lazy var commandPanel: JAMPanel = {

        let panel = JAMPanel()

        let hostingView = NSHostingView(
            rootView: CommandPanelView()
        )

        hostingView.autoresizingMask = [
            .width,
            .height
        ]

        panel.contentView = hostingView

        return panel

    }()

    func showCommandPanel() {

        NSApp.activate(ignoringOtherApps: true)

        if !commandPanel.isVisible {
            commandPanel.center()
        }

        commandPanel.makeKeyAndOrderFront(nil)

        DispatchQueue.main.async {

            guard let textField = SearchFieldRegistry.shared.textField else {
                return
            }

            self.commandPanel.makeFirstResponder(textField)

        }

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

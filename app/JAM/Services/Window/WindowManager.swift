import AppKit

final class WindowManager {

    static let shared = WindowManager()

    private lazy var commandPanel = JAMPanel()

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

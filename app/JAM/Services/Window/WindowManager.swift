import AppKit
import SwiftUI

final class WindowManager {

    static let shared = WindowManager()
  
   
    private var appWindow: NSWindow?

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
    func showAppWindow() {

        NSApp.activate(ignoringOtherApps: true)

        if let window = appWindow {

            window.makeKeyAndOrderFront(nil)

            return

        }

        let window = NSWindow(

            contentRect: NSRect(
                x: 0,
                y: 0,
                width: 900,
                height: 600
            ),

            styleMask: [
                .titled,
                .closable,
                .miniaturizable,
                .resizable
            ],

            backing: .buffered,

            defer: false

        )

        window.title = "JAM"

        window.appearance = AppearanceManager.appearance(
            for: AppearanceSettingsManager.shared.selectedTheme
        )

        window.isReleasedWhenClosed = false

        window.center()

        window.contentView = NSHostingView(

            rootView: JAMWindows()

        )

        self.appWindow = window

        window.makeKeyAndOrderFront(nil)
        window.orderFrontRegardless()

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
    func updateAppearance() {

        let appearance = AppearanceManager.appearance(
            for: AppearanceSettingsManager.shared.selectedTheme
        )

        appWindow?.appearance = appearance

    }
}


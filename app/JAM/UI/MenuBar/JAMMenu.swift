import SwiftUI

struct JAMMenu: View {

    @StateObject
    private var settings = SettingsManager.shared

    var body: some View {

        Button("Open Launcher") {
            WindowManager.shared.showCommandPanel()
        }
        .keyboardShortcut("j", modifiers: [.option])

        Divider()

        Toggle(
            "Global Shortcut",
            isOn: $settings.launcherShortcutEnabled
        )

        Toggle(
            "Launch at Login",
            isOn: $settings.launchAtLogin
        )

        Divider()

        Button("Settings...") {
            WindowManager.shared.showAppWindow()
        }

        Button("About JAM") {

        }

        Divider()

        Button("Quit JAM") {
            NSApplication.shared.terminate(nil)
        }

    }
}

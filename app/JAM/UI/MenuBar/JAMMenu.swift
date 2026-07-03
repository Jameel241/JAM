import SwiftUI

struct JAMMenu: View {

    @StateObject
    private var settings = SettingsManager.shared

    var body: some View {

        Button("Open Assistant") {
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

            NotificationCenter.default.post(
                name: .openGeneralSettings,
                object: nil
            )

        }

        Button("About JAM") {

            WindowManager.shared.showAppWindow()

            NotificationCenter.default.post(
                name: .openAboutSettings,
                object: nil
            )

        }

        Divider()

        Button("Quit JAM") {
            NSApplication.shared.terminate(nil)
        }

    }
}

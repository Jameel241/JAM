import SwiftUI

struct GeneralView: View {

    @StateObject
    private var settings = SettingsManager.shared

    var body: some View {

        Form {

            Section("Application") {

                Toggle(
                    isOn: $settings.launcherShortcutEnabled
                ) {

                    Label("Global Shortcut", systemImage: "keyboard")

                }

                Toggle(
                    isOn: $settings.launchAtLogin
                ) {

                    Label("Launch at Login", systemImage: "power")

                }

                Toggle(
                    isOn: $settings.animationsEnabled
                ) {

                    Label("Animations", systemImage: "sparkles")

                }

            }

            Section("Keyboard") {

                LabeledContent {

                    Text("⌥ J")
                        .font(.title3)
                        .monospaced()

                } label: {

                    Label("Shortcut", systemImage: "command")

                }

            }

            Section("About") {

                LabeledContent {

                    Text("0.1.0")

                } label: {

                    Label("Version", systemImage: "number")

                }
                LabeledContent {

                    Label(
                        "Running",
                        systemImage: "checkmark.circle.fill"
                    )
                    .foregroundStyle(.green)

                } label: {

                    Label("Status", systemImage: "bolt.fill")

                }

            }

        }
        .formStyle(.grouped)

    }

}

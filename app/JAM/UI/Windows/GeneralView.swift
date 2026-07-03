import SwiftUI

struct GeneralView: View {

    @StateObject
    private var settings = SettingsManager.shared

    var body: some View {

        Form {

            PageHeader(
                title: "General",
                subtitle: "Manage how JAM behaves.",
                systemImage: "gearshape"
            )

            SettingsCard(
                title: "Application",
                systemImage: "gearshape"
            ) {

                Toggle(
                    isOn: $settings.launcherShortcutEnabled
                ) {

                    Label(
                        "Global Shortcut",
                        systemImage: "keyboard"
                    )

                }

                Divider()

                Toggle(
                    isOn: $settings.launchAtLogin
                ) {

                    Label(
                        "Launch at Login",
                        systemImage: "power"
                    )

                }

            }
            SettingsCard(
                title: "Keyboard",
                systemImage: "command"
            ) {

                LabeledContent {

                    Text("⌥ J")
                        .font(.title3)
                        .monospaced()

                } label: {

                    Label(
                        "Shortcut",
                        systemImage: "keyboard"
                    )

                }

            }

            SettingsCard(
                title: "About",
                systemImage: "info.circle"
            ) {

                LabeledContent("Version") {

                    Text(AppInfo.version)

                }

                Divider()

                LabeledContent("Status") {

                    StatusBadge(
                        title: "Running",
                        systemImage: "checkmark.circle.fill",
                        color: .green
                    )

                }

            }

        }
        .formStyle(.grouped)

    }

}

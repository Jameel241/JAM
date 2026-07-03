import SwiftUI
import AppKit
struct UpdatesView: View {
    @StateObject
    private var settings = UpdatesSettingsManager.shared
    var body: some View {

        Form {

            PageHeader(
                title: "Updates",
                subtitle: "Keep JAM up to date with the latest improvements.",
                systemImage: "arrow.clockwise.circle"
            )

            SettingsCard(
                title: "Current Version",
                systemImage: "info.circle.fill"
            ) {

                LabeledContent("Version") {

                    Text(AppInfo.version)

                }

                Divider()

                LabeledContent("Build") {

                    Text(AppInfo.build)

                }

                Divider()

                LabeledContent("Channel") {

                    StatusBadge(
                        title: "Stable",
                        systemImage: "checkmark.circle.fill",
                        color: .green
                    )

                }

            }

            SettingsCard(
                title: "Update Settings",
                systemImage: "gearshape.fill"
            ) {

                Toggle(
                    "Automatically Check for Updates",
                    isOn: $settings.automaticallyCheckForUpdates
                )
                
                Divider()
                Toggle(
                    "Include Beta Releases",
                    isOn: $settings.includeBetaReleases
                )

            }

            SettingsCard(
                title: "Status",
                systemImage: "checkmark.shield"
            ) {

                LabeledContent("Current Status") {

                    StatusBadge(
                        title: "Up to Date",
                        systemImage: "checkmark.circle.fill",
                        color: .green
                    )

                }

                Divider()

                LabeledContent("Last Checked") {

                    if let lastChecked = settings.lastChecked {

                        Text(lastChecked.formatted())

                    } else {

                        Text("Not yet checked")

                    }

                }

            }

            SettingsCard(
                title: "Actions",
                systemImage: "arrow.clockwise"
            ) {

                Button("Check for Updates") {

                    settings.lastChecked = Date()

                }

                Divider()

                Button("View Release Notes") {

                    if let url = URL(string: "https://github.com/Jameel241/JAM/releases") {

                        NSWorkspace.shared.open(url)

                    }

                }

            }

            SettingsCard(
                title: "Information",
                systemImage: "doc.text.fill"
            ) {

                Label(
                    "Updates are verified before installation.",
                    systemImage: "checkmark.circle.fill"
                )

                Divider()

                Label(
                    "JAM never installs updates without your permission.",
                    systemImage: "checkmark.circle.fill"
                )

                Divider()

                Label(
                    "Release notes are available for every version.",
                    systemImage: "checkmark.circle.fill"
                )

            }

        }
        .formStyle(.grouped)

    }

}

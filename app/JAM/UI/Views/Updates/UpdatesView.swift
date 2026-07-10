import SwiftUI
import AppKit

struct UpdatesView: View {

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
                title: "Automatic Updates",
                systemImage: "arrow.clockwise.circle.fill"
            ) {

                HStack {

                    Image(systemName: "clock.fill")

                    VStack(
                        alignment: .leading,
                        spacing: 4
                    ) {

                        Text("Coming Soon")

                        Text(
                            "Automatic update checking will be available in a future version of JAM."
                        )
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    }

                    Spacer()
                }
            }

            SettingsCard(
                title: "Actions",
                systemImage: "arrow.up.forward.app"
            ) {

                Button("View Releases") {

                    if let url = URL(
                        string: "https://github.com/Jameel241/JAM/releases"
                    ) {

                        NSWorkspace.shared.open(url)
                    }
                }
            }

            SettingsCard(
                title: "Information",
                systemImage: "doc.text.fill"
            ) {

                Label(
                    "New versions of JAM are published on GitHub Releases.",
                    systemImage: "shippingbox.fill"
                )

                Divider()

                Label(
                    "Release notes and downloads are available from the releases page.",
                    systemImage: "doc.text.fill"
                )
            }
        }
        .formStyle(.grouped)
    }
}

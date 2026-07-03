import SwiftUI
import AppKit
struct PrivacyView: View {

    var body: some View {

        Form {

            PageHeader(
                title: "Privacy",
                subtitle: "Protect your data and control what JAM can access.",
                systemImage: "lock.shield"
            )
            SettingsCard(
                title: "Permissions",
                systemImage: "hand.raised.fill"
            ) {

                LabeledContent("Accessibility") {

                    StatusBadge(
                        title: "Granted",
                        systemImage: "checkmark.circle.fill",
                        color: .green
                    )

                }

                Divider()

                LabeledContent("Notifications") {

                    StatusBadge(
                        title: "Granted",
                        systemImage: "checkmark.circle.fill",
                        color: .green
                    )

                }

                Divider()

                LabeledContent("Full Disk Access") {

                    StatusBadge(
                        title: "Not Required Yet",
                        systemImage: "clock.fill",
                        color: .yellow
                    )

                }

            }
            SettingsCard(
                title: "Data Storage",
                systemImage: "internaldrive.fill"
            ) {

                LabeledContent("Search Index") {

                    StatusBadge(
                        title: "Stored Locally",
                        systemImage: "externaldrive.fill",
                        color: .green
                    )

                }

                Divider()

                LabeledContent("API Keys") {

                    StatusBadge(
                        title: "macOS Keychain",
                        systemImage: "key.fill",
                        color: .green
                    )

                }

                Divider()

                LabeledContent("Clipboard") {

                    StatusBadge(
                        title: "Stored Locally",
                        systemImage: "doc.on.clipboard.fill",
                        color: .green
                    )

                }

                Divider()

                LabeledContent("Chat History") {

                    StatusBadge(
                        title: "Disabled",
                        systemImage: "xmark.circle.fill",
                        color: .gray
                    )

                }

            }
            SettingsCard(
                title: "Actions",
                systemImage: "gearshape.fill"
            ) {

                Button("Open Privacy Settings") {

                    if let url = URL(string: "x-apple.systempreferences:") {
                        NSWorkspace.shared.open(url)
                    }

                }
                Divider()

                Button("Clear Local Data") {

                    Task {
                        await ApplicationRegistry.shared.rebuild()
                        print("Local data cleared.")
                    }

                }

                Divider()

                Button("Reset Permissions") {

                    print("Permission reset is not implemented yet.")

                }

            }
            SettingsCard(
                title: "Privacy",
                systemImage: "lock.fill"
            ) {

                Label(
                    "JAM never uploads your files unless you ask.",
                    systemImage: "checkmark.circle.fill"
                )

                Divider()

                Label(
                    "API keys are stored securely in your macOS Keychain.",
                    systemImage: "checkmark.circle.fill"
                )

                Divider()

                Label(
                    "Search indexes remain on your Mac.",
                    systemImage: "checkmark.circle.fill"
                )

                Divider()

                Label(
                    "You control every permission JAM receives.",
                    systemImage: "checkmark.circle.fill"
                )

            }

        }
        .formStyle(.grouped)

    }

}

import SwiftUI
import AppKit

struct PluginsView: View {
    @StateObject
    private var settings = PluginsSettingsManager.shared
    var body: some View {

        Form {

            PageHeader(
                title: "Plugins",
                subtitle: "Extend JAM with additional capabilities.",
                systemImage: "puzzlepiece.extension"
            )
            SettingsCard(
                title: "Installed Plugins",
                systemImage: "puzzlepiece.extension.fill"
            ) {

                HStack {

                    Image(systemName: "shippingbox")

                    VStack(alignment: .leading) {

                        Text("No Plugins Installed")

                        Text("Plugins will appear here once installed.")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                    }

                    Spacer()

                }

            }
            SettingsCard(
                title: "Marketplace",
                systemImage: "bag.fill"
            ) {

                Label(
                    "Plugin Marketplace is coming soon.",
                    systemImage: "clock.fill"
                )

            }
            SettingsCard(
                title: "Developer",
                systemImage: "hammer.fill"
            ) {

                Toggle(
                    "Developer Mode",
                    isOn: $settings.developerMode
                )

                Divider()

                LabeledContent("Plugin Folder") {

                    Text("~/Library/Application Support/JAM/Plugins")
                        .foregroundStyle(.secondary)

                }

            }
            SettingsCard(
                title: "Security",
                systemImage: "lock.shield.fill"
            ) {

                Label(
                    "Only trusted plugins will be allowed.",
                    systemImage: "checkmark.shield.fill"
                )

                Divider()

                Label(
                    "Plugins run with explicit user permission.",
                    systemImage: "checkmark.shield.fill"
                )

                Divider()

                Label(
                    "Future plugin updates will be verified.",
                    systemImage: "checkmark.shield.fill"
                )

            }
            SettingsCard(
                title: "Actions",
                systemImage: "gearshape.fill"
            ) {

                Button("Open Plugins Folder") {

                    let url = FileManager.default.homeDirectoryForCurrentUser
                        .appendingPathComponent("Library/Application Support/JAM/Plugins")

                    try? FileManager.default.createDirectory(
                        at: url,
                        withIntermediateDirectories: true
                    )

                    NSWorkspace.shared.open(url)

                }
                Divider()

                Button("Reload Plugins") {

#if DEBUG

                    print("Reloading plugins...")

#endif

                }

            }

        }
        .formStyle(.grouped)

    }

}

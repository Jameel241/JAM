import SwiftUI
import Combine

struct SearchView: View {

    @StateObject
    private var settings = SearchSettingsManager.shared
    @StateObject
    private var registry = ApplicationRegistry.shared

    var body: some View {

        Form {

            Section("Applications") {

                Toggle(
                    "Search Applications",
                    isOn: $settings.searchApplications
                )

                Toggle(
                    "Search System Applications",
                    isOn: $settings.searchSystemApplications
                )

                Toggle(
                    "Search Hidden Applications",
                    isOn: $settings.searchHiddenApplications
                )

            }

            Section("Files") {

                Toggle(
                    "Search Files",
                    isOn: $settings.searchFiles
                )

                Toggle(
                    "Search Folders",
                    isOn: $settings.searchFolders
                )

            }

            Section("Status") {

                LabeledContent("Index Status") {

                    if registry.isIndexing {

                        Label(
                            "Indexing",
                            systemImage: "arrow.triangle.2.circlepath"
                        )
                        .foregroundStyle(.orange)

                    } else {

                        Label(
                            "Ready",
                            systemImage: "checkmark.circle.fill"
                        )
                        .foregroundStyle(.green)

                    }

                }

                LabeledContent("Applications Indexed") {

                    Text("\(registry.entries.count)")

                }
                
                Divider()

                LabeledContent("Last Indexed") {

                    if let date = registry.lastIndexed {

                        Text(
                            date.formatted(
                                date: .abbreviated,
                                time: .shortened
                            )
                        )

                    } else {

                        Text("Never")

                    }

                }

                LabeledContent("Last Updated") {

                    Text("Just now")

                }

            }

            Section("Advanced") {

                Button {

                    Task {

                        await registry.rebuild()

                    }

                } label: {

                    Label(

                        "Rebuild Search Index",

                        systemImage: "arrow.clockwise"

                    )

                }
                .disabled(registry.isIndexing)

            }

        }
        .formStyle(.grouped)

    }

}

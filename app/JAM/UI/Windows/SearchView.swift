import SwiftUI
import Combine

struct SearchView: View {

    @StateObject
    private var settings = SearchSettingsManager.shared

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

                    Label(
                        "Ready",
                        systemImage: "checkmark.circle.fill"
                    )
                    .foregroundStyle(.green)

                }

                LabeledContent("Applications Indexed") {

                    Text("352")

                }

                LabeledContent("Last Updated") {

                    Text("Just now")

                }

            }

            Section("Advanced") {

                Button("Rebuild Search Index") {

                }

            }

        }
        .formStyle(.grouped)

    }

}

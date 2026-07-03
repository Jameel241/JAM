import SwiftUI
import Combine

@MainActor
final class SearchSettingsManager: ObservableObject {

    static let shared = SearchSettingsManager()

    @Published var searchApplications: Bool {
        didSet {
            UserDefaults.standard.set(
                searchApplications,
                forKey: "searchApplications"
            )
        }
    }

    @Published var searchSystemApplications: Bool {
        didSet {
            UserDefaults.standard.set(
                searchSystemApplications,
                forKey: "searchSystemApplications"
            )
        }
    }

    @Published var searchHiddenApplications: Bool {
        didSet {
            UserDefaults.standard.set(
                searchHiddenApplications,
                forKey: "searchHiddenApplications"
            )
        }
    }

    @Published var searchFiles: Bool {
        didSet {
            UserDefaults.standard.set(
                searchFiles,
                forKey: "searchFiles"
            )
        }
    }

    @Published var searchFolders: Bool {
        didSet {
            UserDefaults.standard.set(
                searchFolders,
                forKey: "searchFolders"
            )
        }
    }

    private init() {

        searchApplications =
            UserDefaults.standard.object(forKey: "searchApplications") as? Bool ?? true

        searchSystemApplications =
            UserDefaults.standard.object(forKey: "searchSystemApplications") as? Bool ?? true

        searchHiddenApplications =
            UserDefaults.standard.object(forKey: "searchHiddenApplications") as? Bool ?? false

        searchFiles =
            UserDefaults.standard.object(forKey: "searchFiles") as? Bool ?? true

        searchFolders =
            UserDefaults.standard.object(forKey: "searchFolders") as? Bool ?? true

    }

}

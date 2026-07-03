import Foundation

@MainActor
final class SearchManager {

    static let shared = SearchManager()

    private let applicationsIndexer = ApplicationsIndexer()

    private init() { }

    func rebuildApplications() async {

        do {

            let applications =
                try await applicationsIndexer.indexApplications()

            SearchIndex.shared.updateApplications(
                applications
            )

        } catch {

            print("Indexing failed:", error)

        }

    }

}

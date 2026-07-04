import Foundation

struct FolderSuggestionProvider: SuggestionProvider {

    private let searchEngine = FolderSearchEngine()

    func suggestions(for input: String) -> [Suggestion] {

        searchEngine
            .search(input)
            .map { entry in

                Suggestion(
                    kind: .folder,
                    displayText: entry.displayName,
                    completion: entry.displayName,
                    confidence: 800,
                    url: entry.url,
                    subtitle: "Folder"
                )

            }

    }

}

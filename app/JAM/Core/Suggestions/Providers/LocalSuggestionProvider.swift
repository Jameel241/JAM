import Foundation

struct LocalSuggestionProvider: SuggestionProvider {

    private let searchEngine = LocalSearchEngine()

    func suggestions(for input: String) -> [Suggestion] {

        searchEngine
            .search(input)
            .map { result in

                let entry = result.entry

                return Suggestion(
                    kind: suggestionKind(for: entry.kind),
                    displayText: entry.displayName,
                    completion: entry.displayName,
                    confidence: min(max(Double(result.score) / 1000.0, 0.0), 1.0),
                    url: entry.url,
                    subtitle: subtitle(for: entry)
                )

            }

    }

    private func suggestionKind(
        for kind: IndexedItemKind
    ) -> SuggestionKind {

        switch kind {

        case .folder:
            return .folder

        case .file:
            return .file

        }

    }

    private func subtitle(
        for entry: IndexedItem
    ) -> String {

        switch entry.kind {

        case .folder:
            return "Folder"

        case .file:
            return "File"

        }

    }

}

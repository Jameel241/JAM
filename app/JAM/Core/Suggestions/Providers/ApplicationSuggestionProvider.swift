import Foundation

final class ApplicationSuggestionProvider: SuggestionProvider {

    private let searchEngine = ApplicationSearchEngine()

    func suggestions(for input: String) -> [Suggestion] {

        let trimmed = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        guard !trimmed.isEmpty else {
            return []
        }

        let query: String

        if trimmed.hasPrefix("open ") {
            query = String(trimmed.dropFirst(5))
        } else {
            query = trimmed
        }

        return searchEngine
            .search(query)
            .prefix(8)
            .map { result in

                Suggestion(
                    displayText: result.entry.displayName,
                    completion: result.entry.displayName.lowercased(),
                    confidence: Double(result.score) / 1000.0,
                    url: result.entry.url,
                    subtitle: result.entry.category
                )

            }

    }

}

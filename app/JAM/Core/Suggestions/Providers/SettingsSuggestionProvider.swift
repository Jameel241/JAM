import Foundation

final class SettingsSuggestionProvider: SuggestionProvider {

    private let searchEngine = SettingsSearchEngine()

    func suggestions(for input: String) -> [Suggestion] {

        searchEngine
            .search(input)
            .prefix(8)
            .map { result in

                Suggestion(
                    kind: .setting,
                    displayText: result.entry.displayName,
                    completion: result.entry.displayName.lowercased(),
                    confidence: result.confidence,
                    url: SettingsNavigationResolver.url(
                        for: result.entry.resolvedDestination()
                    ),
                    subtitle: result.entry.category
                )
            }
    }
}

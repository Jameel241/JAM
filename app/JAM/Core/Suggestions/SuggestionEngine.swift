import Foundation

final class SuggestionEngine {

    private let providers: [SuggestionProvider]

    private let ranker = SearchRanker()

    init(
        providers: [SuggestionProvider] = [
            ApplicationSuggestionProvider(),
            SettingsSuggestionProvider(),
            LocalSuggestionProvider()
        ]
    ) {
        self.providers = providers
    }

    func suggestions(
        for input: String
    ) -> [Suggestion] {

        let candidates =
            providers.flatMap {
                $0.suggestions(for: input)
            }

        return ranker.rank(
            suggestions: candidates,
            for: input
        )
    }
}

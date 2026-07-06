import Foundation

final class SuggestionEngine {

    private let providers: [SuggestionProvider]

    private let ranker = SearchRanker()
    private let queryNormalizer = SearchQueryNormalizer()

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

        let query = queryNormalizer.normalize(input)

        let candidates =
            providers.flatMap {
                $0.suggestions(for: query)
            }

        return ranker.rank(
            suggestions: candidates,
            for: query
        )
    }
}

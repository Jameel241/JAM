import Foundation

final class SuggestionEngine {

    private let searchProviders: [SuggestionProvider]
    private let commandProvider = CommandSuggestionProvider()

    private let ranker = SearchRanker()
    private let queryNormalizer = SearchQueryNormalizer()

    init(
        searchProviders: [SuggestionProvider] = [
            ApplicationSuggestionProvider(),
            SettingsSuggestionProvider(),
            LocalSuggestionProvider()
        ]
    ) {
        self.searchProviders = searchProviders
    }

    func suggestions(
        for input: String
    ) -> [Suggestion] {

        let query = queryNormalizer.normalize(input)

        let searchCandidates =
            searchProviders.flatMap {
                $0.suggestions(for: query)
            }

        let commandCandidates =
            commandProvider.suggestions(for: input)

        let candidates =
            searchCandidates + commandCandidates

        return ranker.rank(
            suggestions: candidates,
            for: query
        )
    }
}

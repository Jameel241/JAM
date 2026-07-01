import Foundation

final class SuggestionEngine {

    private let providers: [SuggestionProvider]

    init(
        providers: [SuggestionProvider] = [
            ApplicationSuggestionProvider()
        ]
    ) {
        self.providers = providers
    }

    func suggestions(for input: String) -> [Suggestion] {

        providers
            .flatMap { $0.suggestions(for: input) }
            .sorted { $0.confidence > $1.confidence }

    }

}

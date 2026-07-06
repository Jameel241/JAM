import Foundation

struct Suggestion: Identifiable, Equatable {

    let id = UUID()

    let kind: SuggestionKind

    let displayText: String

    let completion: String

    let confidence: Double

    let url: URL?

    let execution: SuggestionExecution

    let subtitle: String

    init(
        kind: SuggestionKind,
        displayText: String,
        completion: String,
        confidence: Double,
        url: URL?,
        subtitle: String,
        execution: SuggestionExecution? = nil
    ) {
        self.kind = kind
        self.displayText = displayText
        self.completion = completion

        // Every suggestion confidence is guaranteed
        // to remain within the search architecture contract.
        self.confidence = min(
            max(confidence, 0.0),
            1.0
        )

        self.url = url

        self.execution = execution ?? {
            if let url {
                return .openURL(url)
            }

            return .none
        }()

        self.subtitle = subtitle
    }
}

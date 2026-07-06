import Foundation

struct RelevanceScorer {

    func score(
        suggestion: Suggestion,
        query: String
    ) -> Double {

        let normalizedQuery = normalize(query)
        let normalizedText = normalize(suggestion.displayText)

        guard !normalizedQuery.isEmpty else {
            return 0
        }

        var score = 0.0

        // MARK: - Match Quality

        if normalizedText == normalizedQuery {

            score += 10_000

        } else if suggestion.kind == .application &&
                    finalWordMatches(
                        text: normalizedText,
                        query: normalizedQuery
                    ) {

            score += 10_500

        } else if containsExactWord(
            text: normalizedText,
            query: normalizedQuery
        ) {

            score += 8_000

        } else if normalizedText.hasPrefix(normalizedQuery) {

            score += 7_000

        } else if wordStartsWithQuery(
            text: normalizedText,
            query: normalizedQuery
        ) {

            score += 5_000

        } else if normalizedText.contains(normalizedQuery) {

            score += 2_000
        }

        // MARK: - Type Priority

        score += typePriority(
            for: suggestion.kind
        )

        // MARK: - Query Coverage

        let coverage =
            Double(normalizedQuery.count)
            /
            Double(max(normalizedText.count, 1))

        score += coverage * 500

        // MARK: - Existing Provider Confidence

        score += suggestion.confidence * 100

        return score
    }

    // MARK: - Normalization

    private func normalize(
        _ value: String
    ) -> String {

        value
            .lowercased()
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )
    }

    // MARK: - Final Word Match

    private func finalWordMatches(
        text: String,
        query: String
    ) -> Bool {

        text
            .split(separator: " ")
            .last
            .map {
                String($0) == query
            }
            ?? false
    }

    // MARK: - Exact Word

    private func containsExactWord(
        text: String,
        query: String
    ) -> Bool {

        text
            .split(separator: " ")
            .contains {
                $0 == query
            }
    }

    // MARK: - Word Prefix

    private func wordStartsWithQuery(
        text: String,
        query: String
    ) -> Bool {

        text
            .split(separator: " ")
            .contains {
                $0.hasPrefix(query)
            }
    }

    // MARK: - Type Priority

    private func typePriority(
        for kind: SuggestionKind
    ) -> Double {

        switch kind {

        case .application:
            return 100

        case .setting:
            return 80

        case .folder:
            return 60

        case .file:
            return 30

        case .command:
            return 20
        }
    }
}

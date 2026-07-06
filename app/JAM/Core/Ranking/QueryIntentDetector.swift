import Foundation

struct QueryIntentDetector {

    func detect(_ query: String) -> QueryIntent {

        let normalizedQuery = normalize(query)

        guard !normalizedQuery.isEmpty else {
            return .general
        }

        // MARK: - Command Intent

        if hasCommandIntent(normalizedQuery) {
            return .command
        }

        // MARK: - General Intent

        return .general
    }

    // MARK: - Command Detection

    private func hasCommandIntent(
        _ query: String
    ) -> Bool {

        let commandPrefixes = [
            "quit",
            "close",
            "hide"
        ]

        return commandPrefixes.contains { prefix in

            query == prefix ||
            query.hasPrefix(prefix + " ")
        }
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
}

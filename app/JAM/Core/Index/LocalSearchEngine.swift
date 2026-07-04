import Foundation

final class LocalSearchEngine {

    func search(_ query: String) -> [LocalSearchResult] {

        let query = query
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        guard !query.isEmpty else {
            return []
        }

        var results: [LocalSearchResult] = []

        for entry in LocalIndexRegistry.shared.entries {

            var score = 0

            for alias in entry.aliases {

                if alias == query {

                    score = max(score, 1000)

                } else if alias.hasPrefix(query) {

                    score = max(
                        score,
                        900 - (alias.count - query.count)
                    )

                } else if alias
                    .split(separator: " ")
                    .contains(where: { $0.hasPrefix(query) }) {

                    score = max(score, 800)

                } else if query.count >= 2 && alias.contains(query) {

                    score = max(score, 600)

                }

            }

            if score > 0 {

                results.append(
                    LocalSearchResult(
                        entry: entry,
                        score: score
                    )
                )

            }

        }

        return results
            .sorted {

                if $0.score != $1.score {
                    return $0.score > $1.score
                }

                return $0.entry.displayName.localizedCaseInsensitiveCompare(
                    $1.entry.displayName
                ) == .orderedAscending

            }
            .prefix(50)
            .map { $0 }

    }

}

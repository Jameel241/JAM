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

            let displayName =
                entry.displayName.lowercased()

            var score = 0

            // Exact full-name match
            if displayName == query {

                score = 1200

            // Full name begins with query
            } else if displayName.hasPrefix(query) {

                score = max(
                    score,
                    1000 - min(
                        displayName.count - query.count,
                        100
                    )
                )

            }

            // Check aliases
            for alias in entry.aliases {

                if alias == query {

                    score = max(score, 950)

                } else if alias.hasPrefix(query) {

                    score = max(
                        score,
                        850 - min(
                            alias.count - query.count,
                            100
                        )
                    )

                } else if alias
                    .split(separator: " ")
                    .contains(where: { $0.hasPrefix(query) }) {

                    score = max(score, 750)

                } else if query.count >= 2 &&
                            alias.contains(query) {

                    score = max(score, 550)

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

                return $0.entry.displayName
                    .localizedCaseInsensitiveCompare(
                        $1.entry.displayName
                    ) == .orderedAscending

            }
            .prefix(50)
            .map { $0 }

    }

}

import Foundation

final class FolderSearchEngine {

    func search(_ query: String) -> [FolderEntry] {

        let query = query
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        guard !query.isEmpty else {
            return []
        }

        var results: [(entry: FolderEntry, score: Int)] = []

        for entry in FolderRegistry.shared.entries {

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
                    (
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

                return $0.entry.displayName < $1.entry.displayName

            }
            .prefix(20)
            .map { $0.entry }

    }

}

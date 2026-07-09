import Foundation

final class ApplicationSearchEngine {

    func search(_ query: String) -> [AppSearchResult] {

        #if DEBUG
        print("Entries:", ApplicationRegistry.shared.entries.count)
        #endif

        let query = query
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        guard !query.isEmpty else {
            return []
        }

        var results: [AppSearchResult] = []

        for entry in ApplicationRegistry.shared.entries {

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

                } else if query.count >= 2 &&
                            alias.contains(query) {

                    score = max(score, 600)

                }
            }

            #if DEBUG

            if entry.displayName
                .lowercased()
                .contains("youtube") {

                print("-------------")
                print("DISPLAY:", entry.displayName)
                print("ALIASES:", entry.aliases)
            }

            #endif

            if score > 0 {

                results.append(
                    AppSearchResult(
                        entry: entry,
                        score: score
                    )
                )
            }
        }

        #if DEBUG
        print("Results found:", results.count)
        #endif

        return results
            .sorted {

                if $0.score != $1.score {
                    return $0.score > $1.score
                }

                return $0.entry.displayName <
                    $1.entry.displayName
            }
            .prefix(20)
            .map { $0 }
    }
}

import Foundation

struct SettingsSearchResult {

    let entry: SettingsEntry

    /// Normalized confidence: 0.0...1.0
    let confidence: Double
}


final class SettingsSearchEngine {

    private let registry: SettingsRegistry

    init(
        registry: SettingsRegistry = .shared
    ) {
        self.registry = registry
    }


    func search(
        _ input: String
    ) -> [SettingsSearchResult] {

        let query = normalize(input)

        guard !query.isEmpty else {
            return []
        }

        return registry.entries
            .compactMap { entry in

                let confidence = confidence(
                    for: entry,
                    query: query
                )

                guard confidence > 0 else {
                    return nil
                }

                return SettingsSearchResult(
                    entry: entry,
                    confidence: confidence
                )
            }
            .sorted {

                if $0.confidence == $1.confidence {

                    return $0.entry.displayName
                        .localizedCaseInsensitiveCompare(
                            $1.entry.displayName
                        ) == .orderedAscending
                }

                return $0.confidence > $1.confidence
            }
    }


    // MARK: - Confidence


    private func confidence(
        for entry: SettingsEntry,
        query: String
    ) -> Double {

        let displayName =
            normalize(entry.displayName)

        let aliases =
            entry.aliases.map(normalize)

        let hierarchy =
            entry.hierarchy.map(normalize)

        let category =
            normalize(entry.category)

        var bestScore = 0.0


        // MARK: Display Name


        if displayName == query {

            bestScore = max(
                bestScore,
                1.0
            )

        } else if displayName.hasPrefix(query) {

            bestScore = max(
                bestScore,
                0.92
            )

        } else if wordStartsWithQuery(
            text: displayName,
            query: query
        ) {

            bestScore = max(
                bestScore,
                0.88
            )

        } else if displayName.contains(query) {

            bestScore = max(
                bestScore,
                0.78
            )
        }


        // MARK: Aliases


        for alias in aliases {

            if alias == query {

                bestScore = max(
                    bestScore,
                    0.97
                )

            } else if alias.hasPrefix(query) {

                bestScore = max(
                    bestScore,
                    0.90
                )

            } else if wordStartsWithQuery(
                text: alias,
                query: query
            ) {

                bestScore = max(
                    bestScore,
                    0.86
                )

            } else if alias.contains(query) {

                bestScore = max(
                    bestScore,
                    0.74
                )
            }
        }


        // MARK: Hierarchy


        for hierarchyItem in hierarchy {

            if hierarchyItem == query {

                bestScore = max(
                    bestScore,
                    0.84
                )

            } else if hierarchyItem.hasPrefix(query) {

                bestScore = max(
                    bestScore,
                    0.78
                )

            } else if wordStartsWithQuery(
                text: hierarchyItem,
                query: query
            ) {

                bestScore = max(
                    bestScore,
                    0.74
                )

            } else if hierarchyItem.contains(query) {

                bestScore = max(
                    bestScore,
                    0.64
                )
            }
        }


        // MARK: Category


        if category == query {

            bestScore = max(
                bestScore,
                0.62
            )

        } else if category.hasPrefix(query) {

            bestScore = max(
                bestScore,
                0.56
            )

        } else if category.contains(query) {

            bestScore = max(
                bestScore,
                0.48
            )
        }


        return min(
            max(bestScore, 0.0),
            1.0
        )
    }


    // MARK: - Word Matching


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

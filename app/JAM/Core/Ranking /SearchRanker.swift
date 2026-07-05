import Foundation

struct SearchRanker {

    private let relevanceScorer =
        RelevanceScorer()

    func rank(
        suggestions: [Suggestion],
        for query: String
    ) -> [Suggestion] {

        suggestions.sorted {

            let firstScore =
                relevanceScorer.score(
                    suggestion: $0,
                    query: query
                )

            let secondScore =
                relevanceScorer.score(
                    suggestion: $1,
                    query: query
                )

            if firstScore == secondScore {

                return $0.displayText
                    .localizedCaseInsensitiveCompare(
                        $1.displayText
                    ) == .orderedAscending
            }

            return firstScore > secondScore
        }
    }
}

import Foundation

struct SearchQueryNormalizer {

    func normalize(_ input: String) -> String {

        var query = input
            .trimmingCharacters(in: .whitespacesAndNewlines)

        let prefixes = [
            "show me ",
            "go to ",
            "open ",
            "search for ",
            "search ",
            "find ",
            "launch "
        ]

        let lowercasedQuery = query.lowercased()

        for prefix in prefixes {

            if lowercasedQuery.hasPrefix(prefix) {

                query.removeFirst(prefix.count)

                return query.trimmingCharacters(
                    in: .whitespacesAndNewlines
                )
            }
        }

        return query
    }
}

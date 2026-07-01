import Foundation

final class ApplicationMatcher {

    private let aliases: [String: String] = [

        "browser": "safari",
        "chrome": "google chrome",
        "code": "visual studio code",
        "vscode": "visual studio code",
        "terminal": "terminal",
        "finder": "finder",
        "notes": "notes",
        "mail": "mail"

    ]

    func bestMatch(
        for name: String,
        in applications: [String: URL]
    ) -> URL? {

        let normalized = name
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        // Exact match
        if let url = applications[normalized] {
            return url
        }

        // Alias match
        if let alias = aliases[normalized],
           let url = applications[alias] {
            return url
        }

        // Prefix match
        if let match = applications.first(where: {
            $0.key.hasPrefix(normalized)
        }) {
            return match.value
        }

        // Contains match
        if let match = applications.first(where: {
            $0.key.contains(normalized)
        }) {
            return match.value
        }

        return nil
    }
}

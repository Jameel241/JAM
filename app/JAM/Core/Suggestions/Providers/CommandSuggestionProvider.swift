import Foundation

final class CommandSuggestionProvider: SuggestionProvider {

    private let searchEngine = ApplicationSearchEngine()

    func suggestions(for input: String) -> [Suggestion] {

        let trimmed = input
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        guard !trimmed.isEmpty else {
            return []
        }

        var suggestions: [Suggestion] = []

        // MARK: - Global Application Commands

        suggestions.append(
            contentsOf: globalApplicationCommands(
                matching: trimmed
            )
        )

        // MARK: - Parsed Application Commands

        suggestions.append(
            contentsOf: applicationCommands(
                for: trimmed
            )
        )

        return suggestions
    }

    // MARK: - Global Application Commands

    private func globalApplicationCommands(
        matching query: String
    ) -> [Suggestion] {

        var suggestions: [Suggestion] = []

        // MARK: Hide All Applications

        let hideAllAliases = [
            "hide all",
            "hide all apps",
            "hide all applications"
        ]

        if matchesCommand(
            query,
            aliases: hideAllAliases
        ) {

            suggestions.append(
                Suggestion(
                    kind: .command,
                    displayText: "Hide All Applications",
                    completion: "hide all applications",
                    confidence: commandConfidence(
                        query,
                        aliases: hideAllAliases
                    ),
                    url: nil,
                    subtitle: "Application Command",
                    execution: .hideAllApplications
                )
            )
        }

        // MARK: Quit All Applications

        let quitAllAliases = [
            "quit all",
            "quit all apps",
            "quit all applications",
            "close all",
            "close all apps",
            "close all applications"
        ]

        if matchesCommand(
            query,
            aliases: quitAllAliases
        ) {

            suggestions.append(
                Suggestion(
                    kind: .command,
                    displayText: "Quit All Applications",
                    completion: "quit all applications",
                    confidence: commandConfidence(
                        query,
                        aliases: quitAllAliases
                    ),
                    url: nil,
                    subtitle: "Application Command",
                    execution: .quitAllApplications
                )
            )
        }

        return suggestions
    }

    // MARK: - Individual Application Commands

    private func applicationCommands(
        for input: String
    ) -> [Suggestion] {

        let commandParser = CommandParser()
        let command = commandParser.parse(input)

        guard command.verb == .quit ||
              command.verb == .close else {
            return []
        }

        let applicationQuery = command.object
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )

        guard !applicationQuery.isEmpty else {
            return []
        }

        // Global commands are handled separately.

        let allQueries = [
            "all",
            "all apps",
            "all applications"
        ]

        guard !allQueries.contains(applicationQuery) else {
            return []
        }

        return searchEngine
            .search(applicationQuery)
            .prefix(8)
            .map { result in

                let applicationName =
                    result.entry.displayName

                return Suggestion(
                    kind: .command,
                    displayText:
                        "\(command.verb.rawValue.capitalized) \(applicationName)",
                    completion:
                        "\(command.verb.rawValue) \(applicationName.lowercased())",
                    confidence: min(
                        max(
                            Double(result.score) / 1000.0,
                            0.0
                        ),
                        1.0
                    ),
                    url: nil,
                    subtitle: "Application Command",
                    execution: .quitApplication(
                        applicationName
                    )
                )
            }
    }

    // MARK: - Command Matching

    private func matchesCommand(
        _ query: String,
        aliases: [String]
    ) -> Bool {

        aliases.contains { alias in

            alias.hasPrefix(query)
            ||
            query.hasPrefix(alias)
        }
    }

    // MARK: - Command Confidence

    private func commandConfidence(
        _ query: String,
        aliases: [String]
    ) -> Double {

        if aliases.contains(query) {
            return 1.0
        }

        let bestCoverage = aliases
            .filter {
                $0.hasPrefix(query)
            }
            .map {

                Double(query.count)
                /
                Double(max($0.count, 1))
            }
            .max()
            ?? 0.0

        return min(
            max(bestCoverage, 0.0),
            1.0
        )
    }
}

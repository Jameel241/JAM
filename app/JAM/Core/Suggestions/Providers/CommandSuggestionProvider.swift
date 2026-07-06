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

        let commandParser = CommandParser()
        let command = commandParser.parse(trimmed)

        guard command.verb == .quit ||
              command.verb == .close else {
            return []
        }

        let applicationQuery = command.object
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard !applicationQuery.isEmpty else {
            return []
        }

        // MARK: - Quit All Applications

        let quitAllQueries = [
            "all",
            "all apps",
            "all applications"
        ]

        if quitAllQueries.contains(applicationQuery) {

            return [
                Suggestion(
                    kind: .command,
                    displayText: "Quit All Applications",
                    completion: "quit all applications",
                    confidence: 1.0,
                    url: nil,
                    subtitle: "Application Command",
                    execution: .quitAllApplications
                )
            ]
        }

        // MARK: - Individual Application

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
}

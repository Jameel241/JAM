import Foundation

final class CommandParser {

    func parse(_ text: String) -> Command {

        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)

        let words = trimmed.split(separator: " ")

        guard let firstWord = words.first else {

            return Command(
                originalText: text,
                verb: .unknown,
                object: ""
            )

        }

        let verb = Verb(rawValue: firstWord.lowercased()) ?? .unknown

        let object = words.dropFirst().joined(separator: " ")

        return Command(
            originalText: text,
            verb: verb,
            object: object
        )
    }
}

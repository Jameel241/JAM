import Foundation

final class IntentResolver {

    func resolve(_ command: Command) -> Action? {

        switch command.verb {

        case .open:
            return OpenApplicationAction(
                applicationName: command.object
            )

        default:

            // If the parser didn't recognize a command,
            // treat the first word as an application name.

            let appName = command.verb.rawValue

            if ApplicationRegistry.shared.url(for: appName) != nil {

                return OpenApplicationAction(
                    applicationName: appName
                )

            }

            return nil

        }

    }

}

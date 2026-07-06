import Foundation

final class IntentResolver {

    func resolve(_ command: Command) -> Action? {

        switch command.verb {

        case .open:
            return OpenApplicationAction(
                applicationName: command.object
            )

        case .quit, .close:
            return QuitApplicationAction(
                applicationName: command.object
            )

        default:

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

import Foundation

final class ApplicationDomain {

    private let applicationService = ApplicationService()

    func handle(_ command: Command) {

        switch command.verb {

        case .open:

            applicationService.openApplication(named: command.object)

        default:
            break

        }

    }

}

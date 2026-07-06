import Foundation

final class QuitApplicationAction: Action {

    private let applicationName: String

    private let applicationService = ApplicationService()

    init(applicationName: String) {
        self.applicationName = applicationName
    }

    func execute() {
        applicationService.quitApplication(
            named: applicationName
        )
    }
}

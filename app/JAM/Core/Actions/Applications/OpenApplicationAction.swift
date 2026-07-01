import Foundation

final class OpenApplicationAction: Action {

    private let applicationName: String

    private let applicationService = ApplicationService()

    init(applicationName: String) {

        self.applicationName = applicationName

    }

    func execute() {

        applicationService.openApplication(named: applicationName)

    }

}

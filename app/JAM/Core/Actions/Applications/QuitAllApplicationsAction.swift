import Foundation

final class QuitAllApplicationsAction: Action {

    private let applicationService = ApplicationService()

    func execute() {

        applicationService.quitAllApplications()
    }
}

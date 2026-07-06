import Foundation

final class HideAllApplicationsAction: Action {

    private let applicationService = ApplicationService()

    func execute() {

        applicationService.hideAllApplications()
    }
}

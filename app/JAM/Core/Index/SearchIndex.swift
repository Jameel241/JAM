import SwiftUI
import Combine
@MainActor
final class SearchIndex: ObservableObject {

    static let shared = SearchIndex()

    @Published
    private(set) var applications: [IndexedApplication] = []

    private init() { }

    func updateApplications(
        _ applications: [IndexedApplication]
    ) {

        self.applications = applications

    }

}

import Foundation
import Combine

@MainActor
final class AppStateManager: ObservableObject {

    static let shared = AppStateManager()

    private enum Keys {
        static let hasCompletedOnboarding = "hasCompletedOnboarding"
        static let preferredName = "preferredName"
    }

    @Published
    private(set) var hasCompletedOnboarding: Bool

    @Published
    var preferredName: String {
        didSet {
            UserDefaults.standard.set(
                preferredName,
                forKey: Keys.preferredName
            )
        }
    }

    private init() {

        hasCompletedOnboarding =
            UserDefaults.standard.bool(
                forKey: Keys.hasCompletedOnboarding
            )

        preferredName =
            UserDefaults.standard.string(
                forKey: Keys.preferredName
            ) ?? ""
    }

    func completeOnboarding() {

        hasCompletedOnboarding = true

        UserDefaults.standard.set(
            true,
            forKey: Keys.hasCompletedOnboarding
        )
    }

    func resetOnboarding() {

        hasCompletedOnboarding = false
        preferredName = ""

        UserDefaults.standard.set(
            false,
            forKey: Keys.hasCompletedOnboarding
        )
    }
}

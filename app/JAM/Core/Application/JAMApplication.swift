import Foundation
import KeyboardShortcuts

@MainActor
final class JAMApplication {

    static let shared = JAMApplication()

    private var hasConfiguredServices = false

    private init() {}

    func start() {

        print("🚀 JAM is starting...")

        configureServicesIfNeeded()

        if AppStateManager.shared.hasCompletedOnboarding {
            startNormalExperience()
        } else {
            startFirstLaunchExperience()
        }
    }
    func completeOnboarding() {

        guard !AppStateManager.shared.hasCompletedOnboarding else {
            return
        }

        print("🎉 Completing JAM onboarding...")

        AppStateManager.shared.completeOnboarding()

        WindowManager.shared.closeOnboardingWindow()

        startNormalExperience()
    }
    private func configureServicesIfNeeded() {

        guard !hasConfiguredServices else {
            return
        }

        hasConfiguredServices = true

        #if DEBUG
        SettingsNavigationValidator.run()
        #endif

        KeyboardShortcuts.onKeyUp(for: .toggleJAM) {

            guard SettingsManager.shared.launcherShortcutEnabled else {
                return
            }

            WindowManager.shared.toggleCommandPanel()
        }
    }

    private func startFirstLaunchExperience() {

        print("👋 Starting first-launch experience...")

        WindowManager.shared.showOnboardingWindow()
    }

    private func startNormalExperience() {

        print("✅ Starting normal JAM experience...")

        _ = LocalIndexRegistry.shared

        LocalFileMonitor.shared.start()

        WindowManager.shared.showCommandPanel()
    }
}

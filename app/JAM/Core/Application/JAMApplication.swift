import Foundation
import KeyboardShortcuts

@MainActor
final class JAMApplication {

    static let shared = JAMApplication()

    private var hasConfiguredServices = false

    private init() {}

    func start() {

        #if DEBUG
        print("🚀 JAM is starting...")
        #endif

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

        #if DEBUG
        print("🎉 Completing JAM onboarding...")
        #endif

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

            if AppStateManager.shared.hasCompletedOnboarding {

                WindowManager.shared.toggleCommandPanel()

            } else {

                WindowManager.shared.showOnboardingWindow()

            }
        }
    }

    private func startFirstLaunchExperience() {

        #if DEBUG
        print("👋 Starting first-launch experience...")
        #endif

        WindowManager.shared.showOnboardingWindow()
    }

    private func startNormalExperience() {

        #if DEBUG
        print("✅ Starting normal JAM experience...")
        #endif

        _ = LocalIndexRegistry.shared

        LocalFileMonitor.shared.start()

        WindowManager.shared.showCommandPanel()
    }
}

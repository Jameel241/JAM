import SwiftUI
import Combine

@MainActor
final class SettingsManager: ObservableObject {

    static let shared = SettingsManager()

    @Published var launcherShortcutEnabled: Bool {
        didSet {

            UserDefaults.standard.set(
                launcherShortcutEnabled,
                forKey: "launcherShortcutEnabled"
            )
        }
    }

    @Published var launchAtLogin: Bool {
        didSet {

            guard !isRestoringLaunchAtLogin else {
                return
            }

            let previousValue = oldValue

            let didUpdate =
                LaunchAtLoginManager.shared.update(
                    enabled: launchAtLogin
                )

            if didUpdate {

                UserDefaults.standard.set(
                    launchAtLogin,
                    forKey: "launchAtLogin"
                )

            } else {

                isRestoringLaunchAtLogin = true
                launchAtLogin = previousValue
                isRestoringLaunchAtLogin = false
            }
        }
    }

    @Published var animationsEnabled: Bool {
        didSet {

            UserDefaults.standard.set(
                animationsEnabled,
                forKey: "animationsEnabled"
            )
        }
    }

    private var isRestoringLaunchAtLogin = false

    private init() {

        launcherShortcutEnabled =
            UserDefaults.standard.object(
                forKey: "launcherShortcutEnabled"
            ) as? Bool ?? true

        launchAtLogin =
            UserDefaults.standard.object(
                forKey: "launchAtLogin"
            ) as? Bool ?? true

        animationsEnabled =
            UserDefaults.standard.object(
                forKey: "animationsEnabled"
            ) as? Bool ?? true
    }
}

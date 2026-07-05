import Foundation
import KeyboardShortcuts

final class JAMApplication {

    static let shared = JAMApplication()

    private init() {}

    func start() {

        print("🚀 JAM is starting...")

        #if DEBUG
        SettingsNavigationValidator.run()
        #endif

        _ = LocalIndexRegistry.shared

        KeyboardShortcuts.onKeyUp(for: .toggleJAM) {

            guard SettingsManager.shared.launcherShortcutEnabled else {
                return
            }

            WindowManager.shared.toggleCommandPanel()
        }

        LocalFileMonitor.shared.start()

        WindowManager.shared.showCommandPanel()
    }
}

import Foundation
import KeyboardShortcuts

final class JAMApplication {

    static let shared = JAMApplication()

    private init() {}

    func start() {

        print("🚀 JAM is starting...")

        KeyboardShortcuts.onKeyUp(for: .toggleJAM) {

            WindowManager.shared.toggleCommandPanel()

        }

        WindowManager.shared.showCommandPanel()

    }

}

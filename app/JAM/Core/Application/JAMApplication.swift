import Foundation

final class JAMApplication {

    static let shared = JAMApplication()

    private init() {}

    func start() {

        print("🚀 JAM is starting...")

        WindowManager.shared.showCommandPanel()

    }

}

import Foundation
import ServiceManagement

@MainActor
final class LaunchAtLoginManager {

    static let shared = LaunchAtLoginManager()

    private init() { }

    func update(enabled: Bool) {

        do {

            if enabled {

                try SMAppService.mainApp.register()

            } else {

                try SMAppService.mainApp.unregister()

            }

        } catch {

            print("Launch at Login error:", error)

        }

    }

}

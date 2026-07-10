import Foundation
import ServiceManagement

@MainActor
final class LaunchAtLoginManager {

    static let shared = LaunchAtLoginManager()

    private init() { }

    @discardableResult
    func update(enabled: Bool) -> Bool {

        do {

            if enabled {

                try SMAppService.mainApp.register()

            } else {

                try SMAppService.mainApp.unregister()

            }

            return true

        } catch {

            #if DEBUG
            print(
                "Launch at Login error:",
                error.localizedDescription
            )
            #endif

            return false
        }
    }
}

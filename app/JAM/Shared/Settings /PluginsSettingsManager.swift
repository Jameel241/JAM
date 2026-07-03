import Foundation
import Combine

@MainActor
final class PluginsSettingsManager: ObservableObject {

    static let shared = PluginsSettingsManager()

    @Published var developerMode: Bool {
        didSet {
            UserDefaults.standard.set(
                developerMode,
                forKey: "PluginDeveloperMode"
            )
        }
    }

    private init() {

        developerMode =
            UserDefaults.standard.object(
                forKey: "PluginDeveloperMode"
            ) as? Bool ?? false

    }

}

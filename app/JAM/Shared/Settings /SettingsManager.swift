import SwiftUI

@MainActor

final class SettingsManager  {

    static let shared = SettingsManager()

    @AppStorage("launcherEnabled")
    var launcherEnabled = true

    @AppStorage("launchAtLogin")
    var launchAtLogin = true

    @AppStorage("animationsEnabled")
    var animationsEnabled = true

    private init() { }

}

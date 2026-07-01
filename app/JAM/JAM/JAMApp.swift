import SwiftUI

@main
struct JAMApp: App {

    @NSApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate

    var body: some Scene {

        Settings {
            EmptyView()
        }

    }

}

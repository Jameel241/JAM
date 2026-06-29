import SwiftUI

@main
struct JAMApp: App {

    init() {
        JAMApplication.shared.start()
    }

    var body: some Scene {

        WindowGroup {
            ContentView()
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
    }
}

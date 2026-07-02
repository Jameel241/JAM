import SwiftUI

struct JAMMenuBar: Scene {

    var body: some Scene {

        MenuBarExtra {
            
            Button("Open Launcher") {

                WindowManager.shared.showCommandPanel()

            }

            Divider()

            Button("Settings...") {

                print("Open Settings")

            }

            Button("About JAM") {

                print("About")

            }

            Divider()

            Button("Quit JAM") {

                NSApplication.shared.terminate(nil)

            }

        } label: {

            Image("JAMMark")
                .renderingMode(.template)

        }

    }

}

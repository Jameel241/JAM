import SwiftUI

struct JAMMenuBar: Scene {

    var body: some Scene {

        MenuBarExtra {

            JAMMenu()

        } label: {

            Image("JAMMark")
                .renderingMode(.template)

        }

    }

}

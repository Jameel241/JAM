import SwiftUI

struct JAMMenuBar: Scene {

    var body: some Scene {

        MenuBarExtra {

            JAMMenu()

        } label: {

            Image(systemName: "sparkles")

                .symbolVariant(.fill)

        }

    }

}

import SwiftUI

struct JAMShortcutBadge: View {

    var body: some View {

        HStack(spacing: 6) {

            JAMKeycap(title: "⌥")
            JAMKeycap(title: "J")

        }

    }

}

#Preview {

    JAMShortcutBadge()
        .padding()
        .background(.black)

}

import SwiftUI

struct StatusBadge: View {

    let title: String
    let systemImage: String
    let color: Color

    var body: some View {

        Label(title, systemImage: systemImage)
            .font(.subheadline.weight(.medium))
            .foregroundStyle(color)

    }

}

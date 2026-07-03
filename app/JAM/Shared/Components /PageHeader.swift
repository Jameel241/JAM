import SwiftUI

struct PageHeader: View {

    let title: String
    let subtitle: String
    let systemImage: String

    var body: some View {

        VStack(alignment: .leading, spacing: 8) {

            Label(title, systemImage: systemImage)
                .font(.largeTitle.bold())

            Text(subtitle)
                .foregroundStyle(.secondary)

        }
        .padding(.bottom, 24)

    }

}

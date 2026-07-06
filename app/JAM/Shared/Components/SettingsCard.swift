import SwiftUI

struct SettingsCard<Content: View>: View {

    let title: String
    let systemImage: String

    @ViewBuilder
    let content: Content

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            Label(title, systemImage: systemImage)
                .font(.title3.weight(.semibold))
            Divider()

            content

        }
        .padding(20)
        .background(.regularMaterial)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 20,
                style: .continuous
            )
        )

    }

}

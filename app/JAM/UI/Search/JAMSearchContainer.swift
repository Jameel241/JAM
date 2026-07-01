import SwiftUI

struct JAMSearchContainer<Content: View>: View {

    @Binding var text: String

    @ViewBuilder
    let content: () -> Content

    private var hasResults: Bool {
        !text.isEmpty
    }

    var body: some View {

        VStack(spacing: 0) {

            content()

        }
        .background {

            RoundedRectangle(
                cornerRadius: hasResults ? 30 : 999,
                style: .continuous
            )
            .fill(JAMMaterials.commandField)

            RoundedRectangle(
                cornerRadius: hasResults ? 30 : 999,
                style: .continuous
            )
            .fill(
                LinearGradient(
                    colors: [
                        Color.white.opacity(0.08),
                        Color.white.opacity(0.02)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )

        }
        .overlay {

            RoundedRectangle(
                cornerRadius: hasResults ? 30 : 999,
                style: .continuous
            )
            .strokeBorder(
                Color.white.opacity(0.12),
                lineWidth: 0.8
            )

        }
        .shadow(
            color: Color.purple.opacity(0.12),
            radius: 36,
            y: 20
        )
        .animation(
            .spring(
                response: 0.38,
                dampingFraction: 0.82
            ),
            value: hasResults
        )

    }

}

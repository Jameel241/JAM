import SwiftUI

struct JAMSearchSurface<Content: View>: View {

    @Binding var text: String

    @ViewBuilder
    var content: Content

    var body: some View {

        VStack(spacing: 0) {

            content

        }
        .frame(maxWidth: .infinity)
        .fixedSize(horizontal: false, vertical: true)
        .background {

            RoundedRectangle(
                cornerRadius: JAMMetrics.searchCornerRadius,
                style: .continuous
            )
            .fill(
                Color.black.opacity(0.22)
            )

            RoundedRectangle(
                cornerRadius: JAMMetrics.searchCornerRadius,
                style: .continuous
            )
            .fill(.ultraThinMaterial)

            RoundedRectangle(
                cornerRadius: JAMMetrics.searchCornerRadius,
                style: .continuous
            )
            .fill(
                LinearGradient(
                    colors: [
                        Color.white.opacity(0.07),
                        Color.white.opacity(0.015)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )

        }
        .overlay {

            RoundedRectangle(
                cornerRadius: JAMMetrics.searchCornerRadius,
                style: .continuous
            )
            .strokeBorder(
                Color.white.opacity(0.09),
                lineWidth: 0.6
            )

        }
        .shadow(
            color: .black.opacity(0.18),
            radius: 26,
            y: 14
        )

    }

}

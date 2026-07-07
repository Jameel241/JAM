import SwiftUI

struct JAMSearchSurface<Content: View>: View {

    @Environment(\.colorScheme)
    private var colorScheme

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
                Color.black.opacity(
                    colorScheme == .dark
                        ? 0.22
                        : 0.16
                )
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
                    colors: colorScheme == .dark
                        ? [
                            Color.white.opacity(0.07),
                            Color.white.opacity(0.015)
                        ]
                        : [
                            Color.black.opacity(0.055),
                            Color.black.opacity(0.025)
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
                colorScheme == .dark
                    ? Color.white.opacity(0.09)
                    : Color.black.opacity(0.14),
                lineWidth: 0.6
            )

        }
        .shadow(
            color: .black.opacity(
                colorScheme == .dark
                    ? 0.18
                    : 0.14
            ),
            radius: 26,
            y: 14
        )

    }

}

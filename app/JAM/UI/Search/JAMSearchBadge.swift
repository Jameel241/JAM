import SwiftUI

struct JAMSearchBadge: View {

    @Environment(\.colorScheme)
    private var colorScheme

    var body: some View {

        ZStack {

            RoundedRectangle(
                cornerRadius: 12,
                style: .continuous
            )
            .fill(
                LinearGradient(
                    colors: colorScheme == .dark
                        ? [
                            Color.white.opacity(0.08),
                            Color.white.opacity(0.03)
                        ]
                        : [
                            Color.black.opacity(0.055),
                            Color.black.opacity(0.025)
                        ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )

            RoundedRectangle(
                cornerRadius: 12,
                style: .continuous
            )
            .strokeBorder(
                colorScheme == .dark
                    ? Color.white.opacity(0.08)
                    : Color.black.opacity(0.09),
                lineWidth: 0.7
            )

            Text("J")
                .font(
                    .system(
                        size: 18,
                        weight: .bold,
                        design: .rounded
                    )
                )
                .foregroundStyle(
                    colorScheme == .dark
                        ? Color.white
                        : Color.black.opacity(0.68)
                )

        }
        .frame(width: 42, height: 42)

    }

}

#Preview {

    ZStack {

        Color.black

        JAMSearchBadge()

    }

}

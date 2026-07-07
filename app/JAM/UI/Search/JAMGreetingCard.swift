import SwiftUI

struct JAMGreetingCard: View {

    @Environment(\.colorScheme)
    private var colorScheme

    let greeting: String

    var body: some View {

        VStack(spacing: 10) {

            Text(greeting)
                .font(JAMTypography.title)
                .foregroundStyle(
                    colorScheme == .dark
                        ? Color.white
                        : Color.black.opacity(0.76)
                )

            Text("What would you like to do?")
                .font(JAMTypography.body)
                .foregroundStyle(
                    colorScheme == .dark
                        ? Color.white.opacity(0.80)
                        : Color.black.opacity(0.52)
                )

        }
        .padding(.horizontal, 42)
        .padding(.vertical, 28)
        .background {

            RoundedRectangle(
                cornerRadius: 30,
                style: .continuous
            )
            .fill(.ultraThinMaterial)

            RoundedRectangle(
                cornerRadius: 30,
                style: .continuous
            )
            .fill(
                colorScheme == .dark
                    ? Color.black.opacity(0.18)
                    : Color.black.opacity(0.06)
            )

        }
        .overlay {

            RoundedRectangle(
                cornerRadius: 30,
                style: .continuous
            )
            .strokeBorder(
                colorScheme == .dark
                    ? Color.white.opacity(0.08)
                    : Color.black.opacity(0.08),
                lineWidth: 0.6
            )

        }

    }

}

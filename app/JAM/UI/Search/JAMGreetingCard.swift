import SwiftUI

struct JAMGreetingCard: View {

    let greeting: String

    var body: some View {

        VStack(spacing: 10) {

            Text(greeting)
                .font(JAMTypography.title)
                .foregroundStyle(.white)

            Text("What would you like to do?")
                .font(JAMTypography.body)
                .foregroundStyle(.white.opacity(0.80))

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
            .fill(Color.black.opacity(0.18))

        }
        .overlay {

            RoundedRectangle(
                cornerRadius: 30,
                style: .continuous
            )
            .strokeBorder(
                Color.white.opacity(0.08),
                lineWidth: 0.6
            )

        }

    }

}

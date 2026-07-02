import SwiftUI

struct JAMSearchBadge: View {

    var body: some View {

        ZStack {

            RoundedRectangle(
                cornerRadius: 12,
                style: .continuous
            )
            .fill(
                LinearGradient(
                    colors: [
                        Color.white.opacity(0.08),
                        Color.white.opacity(0.03)
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
                Color.white.opacity(0.08),
                lineWidth: 0.7
            )

            Text("J")
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(.white)

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

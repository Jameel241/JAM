import SwiftUI

struct JAMKeycap: View {

    @Environment(\.colorScheme)
    private var colorScheme

    let title: String

    var body: some View {

        Text(title)
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(
                colorScheme == .dark
                    ? Color.white.opacity(0.85)
                    : Color.black.opacity(0.58)
            )
            .frame(width: 26, height: 24)
            .background {

                RoundedRectangle(
                    cornerRadius: 7,
                    style: .continuous
                )
                .fill(
                    colorScheme == .dark
                        ? Color.white.opacity(0.06)
                        : Color.black.opacity(0.045)
                )

            }
            .overlay {

                RoundedRectangle(
                    cornerRadius: 7,
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

#Preview {

    HStack {

        JAMKeycap(title: "⌘")
        JAMKeycap(title: "K")

    }
    .padding()
    .background(.black)

}

import SwiftUI

struct JAMKeycap: View {

    let title: String

    var body: some View {

        Text(title)
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(.white.opacity(0.85))
            .frame(width: 26, height: 24)
            .background {

                RoundedRectangle(
                    cornerRadius: 7,
                    style: .continuous
                )
                .fill(Color.white.opacity(0.06))

            }
            .overlay {

                RoundedRectangle(
                    cornerRadius: 7,
                    style: .continuous
                )
                .strokeBorder(
                    Color.white.opacity(0.08),
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

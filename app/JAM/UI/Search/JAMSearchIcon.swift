import SwiftUI

struct JAMSearchIcon: View {

    @Environment(\.colorScheme)
    private var colorScheme

    var body: some View {

        Image(systemName: "magnifyingglass")
            .font(.system(size: 18, weight: .medium))
            .foregroundStyle(
                LinearGradient(
                    colors: colorScheme == .dark
                        ? [
                            Color.white.opacity(0.85),
                            Color(
                                red: 0.72,
                                green: 0.55,
                                blue: 1.0
                            )
                        ]
                        : [
                            Color.black.opacity(0.62),
                            Color.black.opacity(0.42)
                        ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: 22, height: 22)

    }

}

#Preview {

    ZStack {

        Color.black

        JAMSearchIcon()

    }

}

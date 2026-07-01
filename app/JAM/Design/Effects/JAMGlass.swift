import SwiftUI

enum JAMGlass {

    static let search = LinearGradient(
        colors: [
            Color.white.opacity(0.09),
            Color.white.opacity(0.03)
        ],
        startPoint: .top,
        endPoint: .bottom
    )

    static let panel = LinearGradient(
        colors: [
            Color.white.opacity(0.07),
            Color.white.opacity(0.02)
        ],
        startPoint: .top,
        endPoint: .bottom
    )

}

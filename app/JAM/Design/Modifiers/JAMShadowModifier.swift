import SwiftUI

struct JAMShadowModifier: ViewModifier {

    func body(content: Content) -> some View {

        content
            .shadow(
                color: JAMGlow.idle,
                radius: JAMShadow.radius,
                y: JAMShadow.y
            )

    }

}

extension View {

    func jamShadow() -> some View {

        modifier(
            JAMShadowModifier()
        )

    }

}

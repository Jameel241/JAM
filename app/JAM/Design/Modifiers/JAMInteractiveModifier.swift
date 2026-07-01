import SwiftUI

struct JAMInteractiveModifier: ViewModifier {

    var active: Bool

    func body(content: Content) -> some View {

        content
            .animation(
                JAMAnimation.search,
                value: active
            )

    }

}

extension View {

    func jamInteractive(
        active: Bool
    ) -> some View {

        modifier(
            JAMInteractiveModifier(
                active: active
            )
        )

    }

}

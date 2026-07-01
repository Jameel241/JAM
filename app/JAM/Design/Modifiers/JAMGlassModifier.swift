import SwiftUI

struct JAMGlassModifier: ViewModifier {

    var cornerRadius: CGFloat

    func body(content: Content) -> some View {

        content
            .background {

                RoundedRectangle(
                    cornerRadius: cornerRadius,
                    style: .continuous
                )
                .fill(JAMMaterials.commandField)

                RoundedRectangle(
                    cornerRadius: cornerRadius,
                    style: .continuous
                )
                .fill(JAMGlass.search)

            }
            .overlay {

                RoundedRectangle(
                    cornerRadius: cornerRadius,
                    style: .continuous
                )
                .strokeBorder(
                    JAMStroke.subtle,
                    lineWidth: 0.8
                )

            }

    }

}

extension View {

    func jamGlass(
        cornerRadius: CGFloat
    ) -> some View {

        modifier(
            JAMGlassModifier(
                cornerRadius: cornerRadius
            )
        )

    }

}

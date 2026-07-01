import SwiftUI

struct JAMCommandField: View {

    @Binding var text: String

    var onSubmit: () -> Void

    var onUpArrow: (() -> Void)? = nil
    var onDownArrow: (() -> Void)? = nil
    var onTab: (() -> Void)? = nil
    var onEscape: (() -> Void)? = nil

    var body: some View {

        JAMNativeTextField(
            text: $text,
            onSubmit: onSubmit,
            onUpArrow: onUpArrow,
            onDownArrow: onDownArrow,
            onTab: onTab,
            onEscape: onEscape
        )
        .padding(.horizontal, 24)
        .frame(height: 60)
        .background {

            RoundedRectangle(
                cornerRadius: JAMRadius.commandField,
                style: .continuous
            )
            .fill(JAMMaterials.commandField)

            RoundedRectangle(
                cornerRadius: JAMRadius.commandField,
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

        }
        .overlay {

            RoundedRectangle(
                cornerRadius: JAMRadius.commandField,
                style: .continuous
            )
            .strokeBorder(
                Color.white.opacity(0.14),
                lineWidth: 0.6
            )

        }
        .shadow(
            color: .black.opacity(0.08),
            radius: 18,
            y: 10
        )

    }

}

#Preview {

    @Previewable @State var text = ""

    JAMCommandField(
        text: $text,
        onSubmit: {}
    )

}

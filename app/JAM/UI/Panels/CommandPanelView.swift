import SwiftUI

struct FloatingPanelView: View {

    @State private var command = ""
    @FocusState private var isFocused: Bool

    var body: some View {

        VStack(alignment: .leading, spacing: JAMSpacing.lg) {

            Text(greeting)
                .font(JAMTypography.title)

            Text("What would you like to do?")
                .font(JAMTypography.body)
                .foregroundStyle(JAMColors.secondaryText)

            TextField("", text: $command)
                .textFieldStyle(.plain)
                .focused($isFocused)
                .padding(JAMSpacing.md)
                .background(.regularMaterial)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: JAMRadius.medium,
                        style: .continuous
                    )
                )
        }
        .padding(40)
        .frame(minWidth: 620,
               idealWidth: 720,
               maxWidth: 860)
        .onAppear {
            isFocused = true
        }
    }

    private var greeting: String {

        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {

        case 5..<12:
            return "Good morning, Jameel."

        case 12..<17:
            return "Good afternoon, Jameel."

        case 17..<22:
            return "Good evening, Jameel."

        default:
            return "Good night, Jameel."
        }
    }
}

#Preview {
    FloatingPanelView()
}

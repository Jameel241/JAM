import SwiftUI

struct JAMSearchView: View {

    @State private var searchText = ""

    var body: some View {

        VStack(spacing: 28) {

            VStack(spacing: 8) {

                Text(greeting)
                    .font(JAMTypography.title)

                Text("What would you like to do?")
                    .font(JAMTypography.body)
                    .foregroundStyle(JAMColors.secondaryText)

            }

            JAMSearchContainer(text: $searchText) {

                JAMSearchBar(
                    text: $searchText,
                    onSubmit: {}
                )

            }

        }
        .padding(40)

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
    JAMSearchView()
}

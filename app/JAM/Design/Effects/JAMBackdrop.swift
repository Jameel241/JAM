import SwiftUI

struct JAMBackdrop: View {

    var body: some View {

        Rectangle()
            .fill(
                LinearGradient(
                    colors: [
                        Color.black.opacity(0.18),
                        Color.black.opacity(0.10)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .ignoresSafeArea()

    }

}

#Preview {

    ZStack {

        Image(systemName: "photo")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()

        JAMBackdrop()

    }

}

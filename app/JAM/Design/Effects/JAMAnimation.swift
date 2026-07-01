import SwiftUI

enum JAMAnimation {

    static let panel = Animation.spring(
        response: 0.42,
        dampingFraction: 0.82
    )

    static let search = Animation.snappy(
        duration: 0.22
    )

}

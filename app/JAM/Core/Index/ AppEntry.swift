import Foundation

struct AppEntry: Identifiable {

    let id = UUID()

    let displayName: String

    let url: URL

    let aliases: [String]

    let category: String

}

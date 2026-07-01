import Foundation

struct Application: Identifiable {

    let id = UUID()

    let name: String

    let url: URL

    var aliases: [String] = []

}

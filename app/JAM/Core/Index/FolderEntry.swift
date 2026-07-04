import Foundation

struct FolderEntry: Identifiable, Equatable {

    let id: URL

    let displayName: String

    let url: URL

    let aliases: [String]

}

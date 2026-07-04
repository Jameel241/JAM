import Foundation

enum IndexedItemKind: String, Equatable {

    case file
    case folder

}

struct IndexedItem: Identifiable, Equatable {

    let id: URL

    let kind: IndexedItemKind

    let displayName: String

    let url: URL

    let parentPath: String

    let aliases: [String]

}

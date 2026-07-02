import AppKit

final class SearchFieldRegistry {

    static let shared = SearchFieldRegistry()

    weak var textField: NSTextField?

    private init() {}

}

import Foundation

enum SuggestionExecution: Equatable {

    case openURL(URL)

    case quitApplication(String)

    case quitAllApplications

    case none
}

import Foundation

enum AIConnectionState: Equatable {

    case notConfigured
    case notTested
    case testing
    case connected
    case failed(String)

}

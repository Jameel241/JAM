import Foundation

enum Intent {

    case application(Verb)

    case file(Verb)

    case clipboard(Verb)

    case system(Verb)

    case unknown

}

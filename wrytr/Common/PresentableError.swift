import Foundation

protocol PresentableError: Error {
    var title: String { get }
    var description: String { get }
}

extension PresentableError {
    var title: String {
        return "🤔"
    }
}

extension NSError: PresentableError {
    open override var description: String {
        return localizedDescription
    }
}

import Foundation

protocol PresentableError: Error {
    var title: String { get }
    var description: String { get }
}

struct UserlandError: PresentableError {
    let title: String
    let description: String
    
    init(title: String = "🤔", description: String) {
        self.title = title
        self.description = description
    }
}

extension NSError: PresentableError {
    open var title: String {
        return "🤔"
    }
    
    open override var description: String {
        return localizedDescription
    }
}

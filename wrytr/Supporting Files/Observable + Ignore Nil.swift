import Foundation
import RxSwift

public protocol OptionalType {
    func hasValue() -> Bool
}

extension Optional: OptionalType {
    public func hasValue() -> Bool {
        return (self != nil)
    }
}

extension ImplicitlyUnwrappedOptional: OptionalType {
    public func hasValue() -> Bool {
        return (self != nil)
    }
}

public extension ObservableType where E: OptionalType {
    public func ignoreNil() -> Observable<E> {
        return self.filter { $0.hasValue() }
    }
}

//  Copyright © 2016 Martians Inc. All rights reserved.
import Foundation
import RxSwift
import RxCocoa

extension Observable where Element: Equatable {
    func ignore(value: Element) -> Observable<Element> {
        return filter { (e) -> Bool in
            return value != e
        }
    }
}

protocol OptionalType {
    associatedtype T
    var asOptional: T? { get }
}

extension Optional: OptionalType {
    var asOptional: Wrapped? {
        return self
    }
}

extension Observable where Element: OptionalType {
    func ignoreNil() -> Observable<Element.T> {
        return self
            .filter { return $0.asOptional != nil  }
            .map { return $0.asOptional! }
    }
}

extension Driver where Element: OptionalType {
    func ignoreNil() -> Driver<Element.T> {
        return self
            .filter { return $0.asOptional != nil  }
            .map { return $0.asOptional! }
    }
}

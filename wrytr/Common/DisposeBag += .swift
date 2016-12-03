import Foundation
import RxSwift

extension DisposeBag {
    func += (lhs: DisposeBag, rhs: Disposable) {
        lhs.insert(rhs)
    }
}

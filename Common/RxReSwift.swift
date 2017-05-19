import RxSwift
import RxCocoa
import ReSwift

// MARK: - ReactiveStoreSubscriber
/* Custom subscriber that forwards the next events through a PublishSubject */

internal class ReactiveStoreSubscriber<S>: StoreSubscriber {

    internal typealias StoreSubscriberStateType = S
    internal let subject: PublishSubject<S>

    internal init() {
        self.subject = PublishSubject()
    }

    func newState(state: StoreSubscriberStateType) {
        self.subject.onNext(state)
    }

}

// MARK: - ReactiveStoreType
/* ReactiveStoreType is a protocol that defines the reactive behaviour of a state store. */

public protocol ReactiveStoreType {
    associatedtype ReactiveStoreState
    func asObservable<S: StoreSubscriber>() -> Observable<ReactiveStoreState> where S.StoreSubscriberStateType == ReactiveStoreState
}

// MARK: - Store Extension (ReactiveStoreType)
extension Store: ReactiveStoreType {

    public typealias ReactiveStoreState = State

    public func asObservable() -> Observable<ReactiveStoreState> {
        return Observable.create({ (observer) -> Disposable in
            let subscriber = ReactiveStoreSubscriber<ReactiveStoreState>()
            self.subscribe(subscriber)
            return Disposables.create {
                self.unsubscribe(subscriber)
            }
        })
    }

    public func asDriver() -> Driver<ReactiveStoreState> {
        return self.asObservable()
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorRecover: {
                fatalError("this shouldn't ever error (\($0)). We're supposed to just forward those events through")
            })
    }
}

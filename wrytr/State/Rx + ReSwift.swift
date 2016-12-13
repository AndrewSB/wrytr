import RxSwift
import RxCocoa
import ReSwift
import Cordux

/* ReactiveStoreType is a protocol that defines the reactive behaviour of a state store. */
public protocol ReactiveStoreType {
    associatedtype ReactiveStoreState
    func asObservable<S: StoreSubscriber>()-> Observable<ReactiveStoreState> where S.StoreSubscriberStateType == ReactiveStoreState
}

/* Custom subscriber that forwards the next events through a PublishSubject */

internal class ReactiveStoreSubscriber<S>: Cordux.SubscriberType {

    internal typealias StoreSubscriberStateType = S
    internal let subject: PublishSubject<S>

    internal init() {
        self.subject = PublishSubject()
    }

    func newState(_ state: StoreSubscriberStateType) {
        self.subject.onNext(state)
    }

}

extension Cordux.Store: ReactiveStoreType {

    public typealias ReactiveStoreState = State

    public func asObservable() -> Observable<ReactiveStoreState> {
        return Observable.create({ (observer) -> Disposable in
            let subscriber = ReactiveStoreSubscriber<ReactiveStoreState>()
            self.subscribe(subscriber)

            var disposeBag: DisposeBag! = DisposeBag()
            subscriber.subject.asObservable().subscribe(observer).addDisposableTo(disposeBag)

            return Disposables.create {
                self.unsubscribe(subscriber)
                disposeBag = nil
            }
        })
    }

}

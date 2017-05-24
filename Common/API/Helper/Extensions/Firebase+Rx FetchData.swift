import FirebaseDatabase
import RxSwift
import RxCocoa
import RxParseCallback

extension Reactive where Base: DatabaseQuery {

    /// Usually to observe childAdded for UITableViews
    func observeEventType(_ eventType: DataEventType) -> Observable<DataSnapshot> {
        return Observable.create { observer in
            let handle = self.base.observe(eventType) { snapshot in
                observer.onNext(snapshot)
            }

            return Disposables.create {
                self.base.removeObserver(withHandle: handle)
            }
        }
    }

    /// Usually when you just want to read a value
    func observeEventOnce(_ eventType: DataEventType = .value) -> Observable<DataSnapshot> {

        return RxParseCallback.createWithCallback({ observer in
            self.base.observeSingleEvent(of: eventType) { snapshot in
                RxParseCallback.parseUnwrappedOptionalCallback(observer)(snapshot, .none)
            }
        })

    }

}

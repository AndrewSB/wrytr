import FirebaseDatabase
import RxSwift
import RxCocoa
import RxParseCallback

extension Reactive where Base: DatabaseReference {

    func setValue(_ value: Any?) -> Observable<DatabaseReference> {

        return RxParseCallback.createWithCallback({ observer in
            self.base.setValue(value, withCompletionBlock: {
                let listner = RxParseCallback.parseUnwrappedOptionalCallback(observer)
                listner($1, $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
            })
        })

    }

    func setChildByAutoId(_ value: Any!) -> Observable<DatabaseReference> {

        return RxParseCallback.createWithCallback({ observer in
            self.base.childByAutoId().setValue(value, withCompletionBlock: {
                let listner = RxParseCallback.parseUnwrappedOptionalCallback(observer)
                listner($1, $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
            })
        })

    }

}

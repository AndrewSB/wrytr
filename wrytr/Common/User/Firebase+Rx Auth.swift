import Firebase
import RxSwift
import RxCocoa

extension Reactive where Base: Firebase {

    func login(email: String, password: String) -> Observable<UserID> {

        return ParseRxCallbacks.createWithCallback({ observer in
            self.base.authUser(email, password: password, withCompletionBlock: {
                let listner = ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)
                listner($1, $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
            })
        }).map { (authData: FAuthData) in
            return authData.uid
        }

    }

    func signup(email: String, password: String) -> Observable<UserID> {

        return ParseRxCallbacks.createWithCallback({ observer in
            return self.base.createUser(email, password: password, withValueCompletionBlock: { error, dict in
                if let dict = dict {
                    observer.onNext(dict)
                } else {
                    observer.onError(error!)
                }
                observer.onCompleted()
            })
        }).map { (dict: [AnyHashable: Any]) in
            return dict["uid"] as! String
        }

    }

    func authAnon() -> Observable<FAuthData> {

        return ParseRxCallbacks.createWithCallback({ observer in
            self.base.authAnonymously {
                let listner = ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)
                listner($1, $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
            }
        })

    }

    /// Usually facebook
    func oauth(_ provider: String, token: String) -> Observable<FAuthData> {

        return ParseRxCallbacks.createWithCallback({ observer in
            self.base.auth(withOAuthProvider: provider, token: token) {
                let listner = ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)
                listner($1, $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
            }
        })

    }

    /// Usually Twitter
    func oauth(_ provider: String, parameters: [AnyHashable : Any]!) -> Observable<FAuthData> {

        return ParseRxCallbacks.createWithCallback({ observer in
            self.base.auth(withOAuthProvider: provider, parameters: parameters) {
                let listner = ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)
                listner($1, $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
            }
        })

    }
}

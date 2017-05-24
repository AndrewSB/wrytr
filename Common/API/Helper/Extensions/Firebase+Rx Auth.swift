import Firebase
import RxSwift
import RxCocoa
import RxParseCallback

extension Reactive where Base: Auth {

    func login(email: String, password: String) -> Observable<FirebaseAuth.User> {
        return RxParseCallback.createWithCallback { observer in
            self.base.signIn(withEmail: email, password: password, completion: RxParseCallback.parseUnwrappedOptionalCallback(observer))
        }
    }

    func signup(email: String, password: String) -> Observable<FirebaseAuth.User> {
        return RxParseCallback.createWithCallback { observer in
            self.base.createUser(withEmail: email, password: password, completion: RxParseCallback.parseUnwrappedOptionalCallback(observer))
        }
    }

    func authAnon() -> Observable<FirebaseAuth.User> {
        return RxParseCallback.createWithCallback { observer in
            self.base.signInAnonymously(completion: RxParseCallback.parseUnwrappedOptionalCallback(observer))
        }
    }

    func login(with credential: AuthCredential) -> Observable<FirebaseAuth.User> {
        return RxParseCallback.createWithCallback { observer in
            self.base.signIn(with: credential, completion: RxParseCallback.parseUnwrappedOptionalCallback(observer))
        }
    }
}

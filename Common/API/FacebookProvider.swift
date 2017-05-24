import FacebookCore
import FacebookLogin
import RxSwift
import RxParseCallback

class Facebook {

    class Provider {

        static func login(readPermissions: [ReadPermission] = [.email, .publicProfile, .userFriends]) -> Observable<AccessToken> {
            return RxParseCallback.createWithCallback { observer in
                LoginManager().logIn(readPermissions: readPermissions, viewController: .none) { loginResult in
                    switch loginResult {
                    case let .failed(error):
                        observer.onError(error)
                    case .cancelled:
                        observer.onError(UserlandError(description: "It seems like you cancelled the facebook login"))
                        break
                    case let .success(_, _, token):
                        observer.onNext(token)
                    }
                }
            }
        }

    }

}

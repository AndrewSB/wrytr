import Firebase
import TwitterKit
import RxSwift

extension User {
    
    class Service {
        fileprivate static let 🔥 = Firebase.Provider()
        fileprivate static let 🗣 = Facebook.Provider()
        fileprivate static let 🐦 = Twitter.Provider()
        
        static var isLoggedIn: Bool {
            return 🔥.isLoggedIn
        }
        
        static func auth(params: Auth) -> Observable<UserType> {
            return .empty()
            
            switch params {
            case let .signup(name, loginParams):
                guard case let .login(email, password) = loginParams else { assertionFailure("dont repeatedly recurse"); return .never() }
                
                return 🔥.signup(email: email, password: password)
                
                
            case let .login(email, password):
                break
            case .facebook:
                break
            case .twitter:
                break
            }
        }
    }
    
}

extension User.Service {
    indirect enum Auth {
        case signup(name: String, loginParams: Auth)
        
        case login(email: String, password: String)
        case facebook
        case twitter
    }
}

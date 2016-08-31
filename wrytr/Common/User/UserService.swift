import Firebase
import RxSwift

extension User {
    
    class Service {
        static private let 🔥 = Firebase.Provider()
        
        static var isLoggedIn: Bool {
            return 🔥.authData != nil
        }
        
        static func login(email: String, password: String) {
            
        }
        
        static func auth(params: Auth) -> Observable<UserType> {
            return .empty()
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

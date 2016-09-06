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
            switch params {
            case let .signup(name, loginParams):
                guard case let .login(email, password) = loginParams else {
                    assertionFailure("dont repeatedly recurse"); return .never()
                }
                return 🔥.signup(name: name, email: email, password: password)
                
            case let .login(email, password):
                return 🔥.login(email: email, password: password)
                
            case .facebook:
                return 🗣.login()
                    .map { facebookResult in
                        switch facebookResult.token {
                        case .none:
                            let errorMessage = facebookResult.isCancelled ? tr(key: .AuthErrorFacebookCancelled) : tr(key: .AuthErrorFacebookGeneric)
                            throw NSError(localizedDescription: errorMessage, code: -1)
                        case .some(let token):
                            return token.tokenString!
                        }
                    }
                    .flatMap(🔥.facebookAuth)
                
            case .twitter:
                return 🐦.login()
                    .map { twitterResult in
                        return Firebase.Provider.TwitterAuth(
                            userId: twitterResult.userID,
                            oauthToken: twitterResult.authToken,
                            oauthTokenSecret: twitterResult.authTokenSecret
                        )
                    }
                    .flatMap(🔥.twitterAuth)
                
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

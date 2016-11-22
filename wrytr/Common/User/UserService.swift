import Firebase
import TwitterKit
import RxSwift

extension User {

    class Service {
        private static let 🔥 = Firebase.Provider.shared // swiftlint:disable:this variable_name
        fileprivate static let 🗣 = Facebook.Provider() // swiftlint:disable:this variable_name
        fileprivate static let 🐦 = Twitter.Provider() // swiftlint:disable:this variable_name

        static var isLoggedIn: Bool {
            return 🔥.isLoggedIn
        }

        static func fetchUser(userID: UserID) -> Observable<UserType> {
            return 🔥.getUser(withUserID: userID).map { $0 as UserType }
        }

        static func auth(params: Auth) -> Observable<UserType> {
            switch params {
            case let .signup(name, loginParams):
                guard case let .login(email, password) = loginParams else {
                    assertionFailure("dont repeatedly recurse"); return .never()
                }
                return 🔥.signup(name: name, email: email, password: password).map { $0 as UserType }

            case let .login(email, password):
                return 🔥.login(email: email, password: password).map { $0 as UserType }

            case .facebook:
                return 🗣.login()
                    .map { facebookResult in
                        switch facebookResult.token {
                        case .none:
                            let errorMessage = facebookResult.isCancelled ? tr(.authErrorFacebookCancelled) : tr(.authErrorFacebookGeneric)
                            throw NSError(localizedDescription: errorMessage, code: -1)
                        case .some(let token):
                            return token.tokenString!
                        }
                    }
                    .flatMap(🔥.facebookAuth)
                    .map { $0 as UserType }

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
                    .map { $0 as UserType }

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

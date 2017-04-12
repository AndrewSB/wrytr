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

        static var authedUser: UserType? {
            return 🔥.authUser
        }

        static func fetchUser(userID: UserID) -> Observable<UserType> {
            return 🔥.fetchUser(withId: userID).map { $0 as UserType }
        }

        static func facebookAuth() -> Observable<UserType> {
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
        }

        static func twitterAuth() -> Observable<UserType> {
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

        static func signup(name: String, email: String, password: String) -> Observable<UserType> {
            return 🔥.signup(name: name, email: email, password: password).map { $0 as UserType }
        }

        static func login(email: String, password: String) -> Observable<UserType> {
            return 🔥.login(email: email, password: password).map { $0 as UserType }
        }

    }
}

import Firebase
import TwitterKit
import RxSwift

extension User {
    class Service {
        private static let 🔥 = Firebase.Provider.shared // swiftlint:disable:this variable_name
        fileprivate static let 🗣 = Facebook.Provider.self // swiftlint:disable:this variable_name
        fileprivate static let 🐦 = Twitter.Provider.self // swiftlint:disable:this variable_name

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
                .map { authToken in FacebookAuthProvider.credential(withAccessToken: authToken.authenticationToken) }
                .flatMap(Auth.auth().rx.login)
                .map(Firebase.User.init(firebaseUser:))
                .map { $0 as UserType }
        }

        static func twitterAuth() -> Observable<UserType> {
            return 🐦.login()
                .map { session in TwitterAuthProvider.credential(withToken: session.authToken, secret: session.authTokenSecret) }
                .flatMap(Auth.auth().rx.login(with:))
                .map(Firebase.User.init(firebaseUser:))
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

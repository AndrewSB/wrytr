import Firebase
import RxSwift
import RxCocoa

extension Firebase {

    class Provider {
        internal let ref = Firebase(url: "http://wrytr.firebaseio.com")! // swiftlint:disable:this variable_name

        var isLoggedIn: Bool {
            return ref.authData != nil
        }

        var authUser: User? {
            guard let authData = ref.authData else { return nil }

            return scrapeFirebaseAuthData(authData: authData)
        }

        static let shared = Provider()
    }

}

extension Firebase.Provider {
    func login(email: String, password: String) -> Observable<Firebase.User> {
        return ref.rx.login(email: email, password: password).flatMap(self.fetchUser)
    }

    func signup(name: String, email: String, password: String) -> Observable<Firebase.User> {
        return ref.rx.signup(email: email, password: password)
            .flatMap { userID in self.update(user: Firebase.User(id: userID, name: name, photo: nil)) }
    }
}

extension Firebase.Provider {
    func facebookAuth(token: String) -> Observable<Firebase.User> {
        return ref.rx.oauth("facebook", token: token)
            .map(scrapeFirebaseAuthData)
            .flatMap(update)
    }

    struct TwitterAuth {
        let userId: String
        let oauthToken: String
        let oauthTokenSecret: String

        fileprivate var asDict: [AnyHashable : Any]! {
            return [
                "user_id": userId,
                "oauth_token": oauthToken,
                "oauth_token_secret": oauthTokenSecret
            ]
        }
    }

    func twitterAuth(params: TwitterAuth) -> Observable<Firebase.User> {
        return ref.rx.oauth("twitter", parameters: params.asDict)
            .map(scrapeFirebaseAuthData)
            .flatMap(update)
    }

    fileprivate func scrapeFirebaseAuthData(authData: FAuthData) -> Firebase.User {
        guard
            let cachedProfile = authData.providerData!["cachedUserProfile"] as? [AnyHashable: Any],
            let name = cachedProfile["name"] as? String else {
                fatalError()
        }

        let imageUrl = (authData.providerData["profileImageURL"] as? String)
            .flatMap { (urlString: String) in
                var urlString = urlString
                if let normalRange = urlString.range(of: "_normal") {
                    urlString.removeSubrange(normalRange) // hack to get better twitter image URL
                }
                return urlString
            }
            .flatMap { URL(string: $0) }

        return Firebase.User(id: authData.uid, name: name, photo: imageUrl)
    }
}

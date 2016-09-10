import Firebase
import RxSwift
import RxCocoa

extension Firebase {

    class Provider {
        fileprivate let ref = Firebase(url: "http://wrytr.firebaseio.com")! // swiftlint:disable:this variable_name

        var isLoggedIn: Bool {
            return ref.authData != nil
        }
    }

}

extension Firebase.Provider {
    func login(email: String, password: String) -> Observable<Firebase.User> {
        return ref.rx.login(email: email, password: password).flatMap(self.ref.rx.fetchUser)
    }

    func signup(name: String, email: String, password: String) -> Observable<Firebase.User> {
        return ref.rx.signup(email: email, password: password)
            .flatMap { userID in self.update(user: Firebase.User(id: userID, name: name, photo: nil)) }
    }
}

extension Firebase.Provider {
    func facebookAuth(token: String) -> Observable<Firebase.User> {
        return ref.rx.oauth("facebook", token: token).flatMap(scrapeFirebaseAuthData)
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
        return ref.rx.oauth("twitter", parameters: params.asDict).flatMap(scrapeFirebaseAuthData)
    }

    fileprivate func scrapeFirebaseAuthData(authData: FAuthData) -> Observable<Firebase.User> {
        print("authdata was \(authData)")

        let name = authData.providerData["name"] as! String
        let imageUrl = (authData.providerData["profileImageURL"] as? String)
            .flatMap { (urlString: String) in
                var urlString = urlString
                if let normalRange = urlString.range(of: "_normal") {
                    urlString.removeSubrange(normalRange) // hack to get better twitter image URL
                }
                return urlString
            }
            .flatMap { URL(string: $0) }

        return self.update(user: Firebase.User(id: authData.uid, name: name, photo: imageUrl))
    }
}

extension Firebase.Provider {
    func getUser(withUserID userID: UserID) -> Observable<Firebase.User> {
        return ref.rx.fetchUser(withId: userID)
    }

    func update(user newUser: UserType) -> Observable<Firebase.User> {
        return ref.rx.updateUser(userId: newUser.id, newUser: newUser)
    }

}

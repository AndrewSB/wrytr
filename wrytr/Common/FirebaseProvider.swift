import Firebase
import RxSwift
import RxCocoa

extension Firebase {
    
    class Provider {
        fileprivate let ref = Firebase(url: "http://wrytr.firebaseio.com")!
        
        var isLoggedIn: Bool {
            return ref.authData != nil
        }
    }
    
}

extension Firebase.Provider {
    func login(email: String, password: String) -> Observable<UserType> {
        return ref.rx.login(email: email, password: password)
            .flatMap(self.ref.rx.fetchUser)
            .map { $0 as UserType }
    }
    
    func signup(name: String, email: String, password: String) -> Observable<UserType> {
        return ref.rx.signup(email: email, password: password)
            .flatMap { userID in self.update(user: Firebase.User(id: userID, name: name, photo: nil)) }
            .map { $0 as UserType }
    }
}

extension Firebase.Provider {
    func facebookAuth(token: String) -> Observable<UserType> {
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
    
    func twitterAuth(params: TwitterAuth) -> Observable<UserType> {
        return ref.rx.oauth("twitter", parameters: params.asDict).flatMap(scrapeFirebaseAuthData)
    }
    
    fileprivate func scrapeFirebaseAuthData(authData: FAuthData) -> Observable<UserType> {
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
    func getUser(withUserID userID: UserID) -> Observable<UserType> {
        return ref.rx.fetchUser(withId: userID).map { $0 as UserType }
    }
    
    func update(user newUser: UserType) -> Observable<UserType> {
        return ref.rx.updateUser(userId: newUser.id, newUser: newUser).map { $0 as UserType }
    }
    
}


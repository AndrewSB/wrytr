import Firebase

extension Firebase {
    class Provider {
        private let ref = Firebase(url: "http://wrytr.firebaseio.com")!
        
        var isLoggedIn: Bool {
            return ref.authData != nil
        }
        
    }
}

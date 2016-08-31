import Firebase

extension Firebase {
    private static let ref = Firebase(url: "http://wrytr.firebaseio.com")!
    
    class Provider {
        
        static var isLoggedIn: Bool {
            return ref.authData != nil
        }
        
    }
}

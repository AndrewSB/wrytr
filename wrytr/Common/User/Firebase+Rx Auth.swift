import Firebase
import RxSwift

extension Firebase {
    
    /**
     Usually Facebook
     */
    func rx_oauth(_ provider: String, token: String) -> Observable<FAuthData> {
        
        return ParseRxCallbacks.createWithCallback({ observer in
            self.auth(withOAuthProvider: provider, token: token) {
                let listner = ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)
                listner($1, $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
            }
        })
        
    }
    
    /**
     Usually Twitter
     */
    func rx_oauth(_ provider: String, parameters: [String: String]) -> Observable<FAuthData> {
        
        return ParseRxCallbacks.createWithCallback({ observer in
            self.auth(withOAuthProvider: provider, parameters: parameters) {
                let listner = ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)
                listner($1, $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
            }
        })
        
    }
    
    func rx_login(email: String, password: String) -> Observable<UserID> {
        
        return ParseRxCallbacks.createWithCallback({ observer in
            self.authUser(email, password: password, withCompletionBlock: {
                let listner = ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)
                listner($1, $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
            })
        }).map { (authData: FAuthData) in
            return authData.uid
        }
        
    }
    
    func rx_signup(email: String, password: String) -> Observable<UserID> {
        
        return ParseRxCallbacks.createWithCallback({ observer in
            return self.createUser(email, password: password, withValueCompletionBlock: { error, dict in
                let listener = ParseRxCallbacks.rx_parseCallback(observer)
                listener(dict!["uid"] as! UserID, error)
            })
        })
        
    }
    
    func rx_authAnon() -> Observable<FAuthData> {
        
        return ParseRxCallbacks.createWithCallback({ observer in
            self.authAnonymously {
                let listner = ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)
                listner($1, $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
            }
        })
        
    }
    
}

import Foundation

import Firebase

import RxSwift
import RxCocoa

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
    
    func rx_authUser(_ params: AuthenticationProvider.Params) -> Observable<FAuthData> {
        switch params {
        case let .login(email, password):
            return rx_authUser(email, password: password)
        case let .signup(name, .login(email, password)):
            return rx_createUser(email, password: password)
                .flatMap { self.rx_authUser(email, password: password) }
                .flatMap { authData -> Observable<Firebase> in
                    let userRef = firebase.child(byAppendingPath: "users/\(authData.uid)")!
                    let userDict = ["name": name]
                    return userRef.rx_setValue(userDict as AnyObject!)
                }
                .map { $0.authData! }
        default:
            assertionFailure("tf are you doing. Dont recurse and do a .Signup(name, .Signup)")
            return .empty()
        }
    }
    
    fileprivate func rx_createUser(_ email: String, password: String) -> Observable<Void> {
        
        return ParseRxCallbacks.createWithCallback({ observer in
            firebase.createUser(email, password: password, withValueCompletionBlock: { error, dict in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext()
                    observer.onCompleted()
                }
            })
        })
        
    }
    
    fileprivate func rx_authUser(_ email: String, password: String) -> Observable<FAuthData> {
        
        return ParseRxCallbacks.createWithCallback({ observer in
            firebase.authUser(email, password: password, withCompletionBlock: {
                let listner = ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)
                listner($1, $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
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
    
    func rx_setValue(_ value: AnyObject!) -> Observable<Firebase> {
        
        return ParseRxCallbacks.createWithCallback({ observer in
            self.setValue(value) {
                let listner = ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)
                listner($1, $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
            }
        })
        
    }
    
    func rx_setChildByAutoId(_ value: AnyObject!) -> Observable<Firebase> {
        
        return ParseRxCallbacks.createWithCallback({ observer in
            self.childByAutoId().setValue(value) {
                let listner = ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)
                listner($1, $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
            }
        })
        
    }
    
}

extension Firebase {
    
    var loggedIn: Bool {
        return authData != nil
    }
    
}

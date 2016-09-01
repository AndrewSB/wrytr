//import Foundation
//
//import Firebase
//
//import RxSwift
//import RxCocoa
//
//extension Firebase {
//    
//    /**
//     Usually Facebook
//     */
//    func rx_oauth(_ provider: String, token: String) -> Observable<FAuthData> {
//        
//        return ParseRxCallbacks.createWithCallback({ observer in
//            self.auth(withOAuthProvider: provider, token: token) {
//                let listner = ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)
//                listner($1, $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
//            }
//        })
//        
//    }
//    
//    /**
//     Usually Twitter
//     */
//    func rx_oauth(_ provider: String, parameters: [String: String]) -> Observable<FAuthData> {
//        
//        return ParseRxCallbacks.createWithCallback({ observer in
//            self.auth(withOAuthProvider: provider, parameters: parameters) {
//                let listner = ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)
//                listner($1, $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
//            }
//        })
//        
//    }
//    
//    fileprivate func rx_authUser(_ email: String, password: String) -> Observable<FAuthData> {
//        
//        return ParseRxCallbacks.createWithCallback({ observer in
//            firebase.authUser(email, password: password, withCompletionBlock: {
//                let listner = ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)
//                listner($1, $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
//            })
//        })
//        
//    }
//    
//    func rx_authAnon() -> Observable<FAuthData> {
//        
//        return ParseRxCallbacks.createWithCallback({ observer in
//            self.authAnonymously {
//                let listner = ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)
//                listner($1, $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
//            }
//        })
//        
//    }
//    
//    func rx_setValue(_ value: AnyObject!) -> Observable<Firebase> {
//        
//        return ParseRxCallbacks.createWithCallback({ observer in
//            self.setValue(value) {
//                let listner = ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)
//                listner($1, $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
//            }
//        })
//        
//    }
//    
//    func rx_setChildByAutoId(_ value: AnyObject!) -> Observable<Firebase> {
//        
//        return ParseRxCallbacks.createWithCallback({ observer in
//            self.childByAutoId().setValue(value) {
//                let listner = ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)
//                listner($1, $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
//            }
//        })
//        
//    }
//    
//}

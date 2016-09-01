import FBSDKCoreKit
import FBSDKLoginKit
import RxSwift

class Facebook {

    class Provider {
        
        func login(withReadPermissions permissions: [String] = ["email", "public_profile", "user_friends"]) -> Observable<FBSDKLoginManagerLoginResult> {
        
            return ParseRxCallbacks.createWithCallback({ observer in
                self.logIn(withReadPermissions: readPermissions, from: nil, handler: ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer))
            })
            
        }
        
    }
    
}

import Foundation

import RxSwift
import RxCocoa

import FBSDKCoreKit
import FBSDKLoginKit

extension FBSDKLoginManager {

    func rx_login() -> Observable<FBSDKLoginManagerLoginResult> {
        let readPermissions = ["email", "public_profile", "user_friends"]
        
        return ParseRxCallbacks.createWithCallback({ observer in
            self.logIn(withReadPermissions: readPermissions, from: nil, handler: ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer))
        })
        
    }

}

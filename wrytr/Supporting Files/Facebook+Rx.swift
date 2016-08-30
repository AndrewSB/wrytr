import Foundation

import RxSwift
import RxCocoa

import FBSDKCoreKit
import FBSDKLoginKit

extension FBSDKLoginManager {

    func rx_login() -> Observable<FBSDKLoginManagerLoginResult> {
        let readPermissions = ["email", "public_profile", "user_friends"]
        
        return ParseRxCallbacks.createWithCallback({ observer in
            self.logInWithReadPermissions(readPermissions, fromViewController: nil, handler: ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer))
        })
        
    }

}

//
//  Firebase+Rx.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/1/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

import Firebase

import RxSwift
import RxCocoa

extension Firebase {
    
    /**
     Usually Facebook
     */
    func rx_oauth(provider: String, token: String) -> Observable<FAuthData> {
        
        return ParseRxCallbacks.createWithCallback({ observer in
            self.authWithOAuthProvider(provider, token: token) {
                ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)(object: $1, error: $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
            }
        })
        
    }
    
    /**
     Usually Twitter
     */
    func rx_oauth(provider: String, parameters: [NSObject: AnyObject]) -> Observable<FAuthData> {
        
        return ParseRxCallbacks.createWithCallback({ observer in
            self.authWithOAuthProvider(provider, parameters: parameters) {
                ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)(object: $1, error: $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
            }
        })
        
    }
    
    func rx_authAnon() -> Observable<FAuthData> {
        
        return ParseRxCallbacks.createWithCallback({ observer in
            self.authAnonymouslyWithCompletionBlock {
                ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)(object: $1, error: $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
            }
        })
        
    }
    
    func rx_setValue(value: AnyObject!) -> Observable<Firebase> {
        
        return ParseRxCallbacks.createWithCallback({ observer in
            self.setValue(value) { (error, firebaseRef) in
                ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)(object: firebaseRef, error: error) // Firebase Y U switch the order of object & error? Conventions exist for a reason
            }
        })
        
    }
    
    func rx_setChildByAutoId(value: AnyObject!) -> Observable<Firebase> {
        
        return ParseRxCallbacks.createWithCallback({ observer in
            self.childByAutoId().setValue(value) { (error, firebaseRef) in
                ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)(object: firebaseRef, error: error) // Firebase Y U switch the order of object & error? Conventions exist for a reason
            }
        })
        
    }
    
}

extension Firebase {
    
    var loggedIn: Bool {
        return authData != nil
    }
    
}
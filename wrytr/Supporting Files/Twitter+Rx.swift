//
//  Twitter+Rx.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 3/21/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

import RxSwift

import Twitter
import TwitterKit

extension Twitter {

    func rx_login() -> Observable<TWTRSession> {
    
        return ParseRxCallbacks.createWithCallback({ observer in
            self.logInWithCompletion(ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer))
        })
    
    }

}
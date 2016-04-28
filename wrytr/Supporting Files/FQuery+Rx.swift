//
//  FQuery+Rx.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/25/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

import Firebase

import RxSwift
import RxCocoa

extension FQuery {
    
    /**
     Usually to observe childAdded
     */
    func rx_observeEventType(eventType: FEventType) -> Observable<FDataSnapshot> {
        
        return ParseRxCallbacks.createWithCallback({ observer in
            self.observeEventType(eventType) { snapshot in
                observer.onNext(snapshot)
            }
            
        })
        
    }
    
    func rx_observeEventOnce(eventType: FEventType) -> Observable<FDataSnapshot> {
        
        return ParseRxCallbacks.createWithCallback({ observer in
            self.observeSingleEventOfType(eventType) { snapshot in
                ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)(object: snapshot, error: nil)
            }
        })
        
    }
    
}
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
    func rx_observeEventType(eventType: FEventType = .ChildAdded) -> Observable<FDataSnapshot> {
        
        return ParseRxCallbacks.createWithCallback({ observer in
            self.observeEventType(eventType) { snapshot in
                observer.onNext(snapshot)
            }
            
        })
        
    }
    
}
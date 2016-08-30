import Foundation

import Firebase

import RxSwift
import RxCocoa

extension FQuery {
    
    /**
     Usually to observe childAdded
     */
    func rx_observeEventType(_ eventType: FEventType) -> Observable<FDataSnapshot> {
        
        return ParseRxCallbacks.createWithCallback({ observer in
            self.observe(eventType) { snapshot in
                observer.onNext(snapshot!)
            }
            
        })
        
    }
    
    func rx_observeEventOnce(_ eventType: FEventType) -> Observable<FDataSnapshot> {
        
        return ParseRxCallbacks.createWithCallback({ observer in
            self.observeSingleEvent(of: eventType) { snapshot in
                ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)(snapshot, nil)
            }
        })
        
    }
    
}

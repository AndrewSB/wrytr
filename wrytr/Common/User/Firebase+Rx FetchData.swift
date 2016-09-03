import Firebase
import RxSwift
import RxCocoa

extension Reactive where Base: FQuery {
    
    /// Usually to observe childAdded for UITableViews
    func observeEventType(_ eventType: FEventType) -> Observable<FDataSnapshot> {
        
        return ParseRxCallbacks.createWithCallback({ observer in
            self.base.observe(eventType) { snapshot in
                observer.onNext(snapshot!)
            }
            
        })
        
    }
    
    /// Usually when you just want to read a value
    func observeEventOnce(_ eventType: FEventType = .value) -> Observable<FDataSnapshot> {
        
        return ParseRxCallbacks.createWithCallback({ observer in
            self.base.observeSingleEvent(of: eventType) { snapshot in
                ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)(snapshot, nil)
            }
        })
        
    }
    
}

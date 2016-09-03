import Firebase
import RxSwift
import RxCocoa

extension Reactive where Base: Firebase {
    func bruh() {}
}

extension Firebase {
    
    func rx_setValue(_ value: AnyObject!) -> Observable<Firebase> {
        
        return ParseRxCallbacks.createWithCallback({ observer in
            self.setValue(value) {
                let listner = ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)
                listner($1, $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
            }
        })
        
    }
    
    func rx_setChildByAutoId(_ value: AnyObject!) -> Observable<Firebase> {
        
        return ParseRxCallbacks.createWithCallback({ observer in
            self.childByAutoId().setValue(value) {
                let listner = ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer)
                listner($1, $0) // Firebase Y U switch the order of object & error? Conventions exist for a reason
            }
        })
        
    }
    
}

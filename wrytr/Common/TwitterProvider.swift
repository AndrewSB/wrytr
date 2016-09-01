import TwitterKit
import RxSwift

extension Twitter {
    
    class Provider {
        
        func login() -> Observable<TWTRSession> {
            return ParseRxCallbacks.createWithCallback({ observer in
                self.logIn(completion: ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer))
            })
        }
        
    }
    
}

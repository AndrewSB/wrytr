import TwitterKit
import RxSwift

extension Twitter {

    class Provider {

        func login() -> Observable<TWTRSession> {
            return ParseRxCallbacks.createWithCallback({ observer in
                Twitter.sharedInstance().logIn(completion: ParseRxCallbacks.rx_parseUnwrappedOptionalCallback(observer))
                return
            })
        }

    }

}

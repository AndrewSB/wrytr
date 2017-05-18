import TwitterKit
import RxSwift
import RxParseCallback

extension Twitter {

    class Provider {

        func login() -> Observable<TWTRSession> {
            return ParseRxCallbacks.createWithCallback({ observer in
                Twitter.sharedInstance().logIn(completion: ParseRxCallbacks.parseUnwrappedOptionalCallback(observer))
            })
        }

    }

}

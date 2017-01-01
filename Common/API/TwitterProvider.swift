import TwitterKit
import RxSwift
import RxParseCallbacks

extension Twitter {

    class Provider {

        func login() -> Observable<TWTRSession> {
            return ParseRxCallbacks.createWithCallback({ observer in
                Twitter.sharedInstance().logIn(completion: ParseRxCallbacks.parseUnwrappedOptionalCallback(observer))
            })
        }

    }

}

import TwitterKit
import RxSwift
import RxParseCallback

extension Twitter {

    class Provider {

        static func login() -> Observable<TWTRSession> {
            return RxParseCallback.createWithCallback({ observer in
                Twitter.sharedInstance().logIn(completion: RxParseCallback.parseUnwrappedOptionalCallback(observer))
            })
        }

    }

}

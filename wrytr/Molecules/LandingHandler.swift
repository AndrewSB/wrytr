import UIKit
import RxSwift

extension Landing {

    class Handler: HandlerType {
        private let disposeBag = DisposeBag()

        let store: Store

        init(store: Store) {
            self.store = store
        }

        func twitterTap() {
            store.dispatch(Authentication.signIn(.twitter))
        }

        func facebookTap() {
            store.dispatch(Authentication.signIn(.facebook))
        }

        func actionTap(authData: User.Service.Auth) {
            store.dispatch(Authentication.signIn(authData))
        }

        func changeAuthOptionTap(option: ViewModel.Option) {
            store.dispatch(Landing.Action.updateOption(option))
        }

        func errorOkTap() {
            store.dispatch(Landing.Action.dismissError)
        }

    }

}

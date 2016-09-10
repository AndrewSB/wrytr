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
            store.dispatch(Landing.Action.startLoading)

            let (disposable, asyncSignIn) = Authentication.signIn(.twitter)
            store.dispatch(asyncSignIn)
            disposable.flatMap(disposeBag.insert) // THIS IS A PROBLEM
        }

        func facebookTap() {
            store.dispatch(Landing.Action.startLoading)

            let (disposable, asyncSignIn) = Authentication.signIn(.facebook)
            store.dispatch(asyncSignIn)
            disposable.flatMap(disposeBag.insert) // THIS IS A PROBLEM
        }

        func actionTap(authData: User.Service.Auth) {
            store.dispatch(Landing.Action.startLoading)

            let (disposable, asyncSignIn) = Authentication.signIn(authData)
            store.dispatch(asyncSignIn)
            disposable.flatMap(disposeBag.insert) // THIS IS A PROBLEM
        }

        func changeAuthOptionTap(option: ViewModel.Option) {
            store.dispatch(Landing.Action.updateOption(option))
        }

        func errorOkTap() {
            store.dispatch(Landing.Action.dismissError)
        }

    }

}

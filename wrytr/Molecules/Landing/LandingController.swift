import UIKit
import RxSwift
import RxCocoa
import Cordux

extension Landing {

    class Controller {
        private let disposeBag = DisposeBag()

        init(
            input: (
                button: (
                    facebook: ControlEvent<Void>,
                    twitter: ControlEvent<Void>,
                    action: ControlEvent<Void>,
                    switchOption: ControlEvent<Void>,
                    dismissError: Driver<Void>
                ),
                text: (
                    username: ControlProperty<String?>,
                    email: ControlProperty<String?>,
                    password: ControlProperty<String?>
                )
            ),
            store: StoreDependency = defaultStoreDependency
        ) {

            input.button.facebook.map(Authentication.Action.facebookLogin)
                .bind(onNext: store.dispatcher.dispatch)
                .addDisposableTo(disposeBag)

            input.button.twitter.map(Authentication.Action.twitterLogin)
                .bind(onNext: store.dispatcher.dispatch)
                .addDisposableTo(disposeBag)

            input.button.dismissError.map { Landing.Action.dismissError }
                .drive(onNext: store.dispatcher.dispatch)
                .addDisposableTo(disposeBag)

// TODO: username validation?
//            disposeBag += username.asDriver().drive(onNext: )

            store.state.asDriver()
                .map { $0.landingState.option }
                .flatMapLatest { option in
                    input.button.action.asDriver().map { option }
                }
                .withLatestFrom(Driver.combineLatest(
                    input.text.username.orEmpty.asDriver(),
                    input.text.email.orEmpty.asDriver(),
                    input.text.password.orEmpty.asDriver()
                ) { (username: $0, email: $1, password: $2) }) { option, fields -> Store<App.State>.AsyncAction in
                    switch option {
                    case .login:
                        return Authentication.Action.login(email: fields.email, password: fields.password)
                    case .register:
                        return Authentication.Action.signup(name: fields.username, email: fields.email, password: fields.password)
                    }
                }
                .drive(onNext: store.dispatcher.dispatch)
                .addDisposableTo(disposeBag)

            input.button.switchOption.asDriver()
                .scan(store.state.value.landingState.option) { previousState, _ in
                    switch previousState {
                    case .login: return .register
                    case .register: return .login
                    }
                }
                .drive(onNext: { newOption in
                    store.dispatcher.dispatch(Landing.Action.updateOption(newOption))
                })
                .addDisposableTo(disposeBag)
        }
    }
}

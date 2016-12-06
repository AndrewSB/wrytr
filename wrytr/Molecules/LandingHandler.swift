import UIKit
import RxSwift
import RxCocoa

extension Landing {

    class Output {
        private let disposeBag = DisposeBag()

        // swiftlint:disable:next function_parameter_count
        init(facebookTap: ControlEvent<Void>,
             twitterTap: ControlEvent<Void>,
             username: ControlProperty<String>,
             email: ControlProperty<String>,
             password: ControlProperty<String>,
             actionTap: ControlEvent<Void>,
             switchOptionTap: ControlEvent<Void>) {

            disposeBag += facebookTap.asDriver().map {  }.drive(onNext: Handler.facebookTap)

            disposeBag += twitterTap.asDriver().drive(onNext: Handler.twitterTap)

            disposeBag += username.asDriver().drive(onNext: )

            disposeBag += actionButton.rx.tap.asDriver()
                .map {
                    return (
                        usernameField.text ?? "",
                        emailField.text ?? "",
                        passwordField.text ?? ""
                    )
                }
                .drive(onNext: Landing.Handler.actionTap)
            disposeBag += helperButton.rx.tap.asDriver()
                .scan(Landing.State.Option.login) { previousState, _ in
                    switch previousState {
                    case .login: return .register
                    case .register: return .login
                    }
                }
                .drive(onNext: Landing.Handler.changeAuthOptionTap)
        }
    }

    private class Handler {

        static func twitterTap() {
            store.dispatch(Authentication.signIn(.twitter))
        }

        static func facebookTap() {
            store.dispatch(Authentication.signIn(.facebook))
        }

        static func actionTap(name: String, email: String, password: String) {
            store.dispatch(Authentication.signIn(authData))
        }

        static func changeAuthOptionTap(option: ViewModel.Option) {
            store.dispatch(Landing.Action.updateOption(option))
        }

        static func errorOkTap() {
            store.dispatch(Landing.Action.dismissError)
        }

    }
}

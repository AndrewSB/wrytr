import UIKit
import Library
import RxSwift
import RxCocoa
import Cordux

extension Landing {

    class UI: UIType {
        weak var loaderAndErrorPresenter: (ErrorPresentable & LoadingIndicatable)?

        let interface: ViewController.IB
        let handler: Handler

        lazy var bindings: [Disposable] = [
            self.interface.facebookButton.rx.tap.asDriver().drive(onNext: self.handler.facebookTap),
            self.interface.twitterButton.rx.tap.asDriver().drive(onNext: self.handler.twitterTap),
            self.interface.actionButton.rx.tap.asDriver()
                .map {
                    let name = self.interface.emailField.text ?? "", email = self.interface.emailField.text ?? "", password = self.interface.passwordField.text ?? ""

                    switch store.state.landingState.option {
                    case .login:
                        return User.Service.Auth.login(email: email, password: password)
                    case .register:
                        return User.Service.Auth.signup(name: name, loginParams: .login(email: email, password: password))
                    }
                }
                .drive(onNext: self.handler.actionTap),
            self.interface.helperButton.rx.tap.asDriver()
                .scan(ViewModel.Option.login) { previousState, _ in
                    switch previousState {
                    case .login: return .register
                    case .register: return .login
                    }
                }
                .drive(onNext: self.handler.changeAuthOptionTap)
        ]

        init(interface: ViewController.IB, handler: Handler) {
            self.interface = {
                $0.formContainer.addEdgePadding()

                $0.subtitle.text = tr(.loginLandingSubtitle)

                $0.titleLabel.text = tr(.loginLandingSocialButtonTitle)

                $0.twitterButton.configure(withColor: UIColor(named: .twitterBlue))
                $0.facebookButton.configure(withColor: UIColor(named: .facebookBlue))

                [$0.usernameField, $0.emailField, $0.passwordField].forEach { field in field.configure() }

                $0.termsOfServiceButton.attributize()

                $0.helperButton.layer.borderColor = UIColor(named: .loginLandingBackround).cgColor
                $0.helperButton.layer.borderWidth = 1

                return $0
            }(interface)

            self.handler = handler
        }
    }

}

extension Landing.UI: Renderer {
    func render(_ viewModel: Landing.ViewModel) {
        renderAuthOption(option: viewModel.option)

        _ = viewModel.loading ? showLoading() : hideLoading()
        viewModel.error.flatMap { err in
            let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: self.handler.errorOkTap)
            self.presentError(error: err, actions: [okAction])
        }
    }

    fileprivate func renderAuthOption(option: Landing.ViewModel.Option) {
        let wordedOption: String
        let oppositeWordedOption: String
        let helperTitle: String
        switch option {
        case .login:
            wordedOption = tr(.loginLandingLoginTitle)
            oppositeWordedOption = tr(.loginLandingRegisterTitle)
            helperTitle = tr(.loginLandingHelperLoginTitle)
        case .register:
            wordedOption = tr(.loginLandingRegisterTitle)
            oppositeWordedOption = tr(.loginLandingLoginTitle)
            helperTitle = tr(.loginLandingHelperRegisterTitle)
        }

        self.interface.formContainer.layoutIfNeeded()

        self.interface.formHeader.text = tr(L10n.loginLandingEmailbuttonTitle(wordedOption))
        self.interface.usernameField.isHidden = option == .login
        self.interface.actionButton.set(title: wordedOption)
        self.interface.helperButton.set(title: oppositeWordedOption)
        self.interface.helperLabel.text = helperTitle

        UIView.animate(withDuration: 0.2) {
            self.interface.formContainer.layoutIfNeeded()
        }
    }
}

fileprivate extension UIButton {
    fileprivate func configure(withColor color: UIColor) {
        let renderedImage = self.imageView!.image!.withRenderingMode(.alwaysTemplate)
        self.setImage(renderedImage, for: .normal)
        self.imageView!.contentMode = .scaleAspectFit

        self.tintColor = color

        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
    }

    fileprivate func attributize() {
        let title = self.titleLabel!.text!
        let range = NSRange.init(ofString: "Terms & Privacy Policy", inString: title)

        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttributes([NSForegroundColorAttributeName: UIColor(named: .loginLandingBackround)], range: range)
        self.setAttributedTitle(attributedString, for: .normal)

        self.titleLabel!.lineBreakMode = .byWordWrapping
    }
}

fileprivate extension InsettableTextField {
    fileprivate func configure() {
        insetX = 8
        insetY = 5

        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor

        layer.cornerRadius = 4
        clipsToBounds = true
    }
}

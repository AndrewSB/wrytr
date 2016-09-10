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

        fileprivate var currentOption: ViewModel.Option = .login

        lazy var bindings: [Disposable] = [
            self.interface.facebookButton.rx.tap.asDriver().drive(onNext: self.handler.facebookTap),
            self.interface.twitterButton.rx.tap.asDriver().drive(onNext: self.handler.twitterTap),
            self.interface.actionButton.rx.tap.asDriver()
                .map {
                    let name = self.interface.emailField.text ?? "", email = self.interface.emailField.text ?? "", password = self.interface.passwordField.text ?? ""

                    switch self.currentOption {
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

                $0.subtitle.text = tr(key: .LoginLandingSubtitle)

                $0.titleLabel.text = tr(key: .LoginLandingSocialButtonTitle)

                $0.twitterButton.configure(withColor: UIColor(named: .TwitterBlue))
                $0.facebookButton.configure(withColor: UIColor(named: .FacebookBlue))

                [$0.usernameField, $0.emailField, $0.passwordField].forEach { field in field.configure() }

                $0.termsOfServiceButton.attributize()

                $0.helperButton.layer.borderColor = UIColor(named: .LoginLandingBackround).cgColor
                $0.helperButton.layer.borderWidth = 1

                return $0
            }(interface)

            self.handler = handler
        }
    }

}

extension Landing.UI: Renderer {
    typealias ViewModel = Landing.ViewModel

    func render(_ viewModel: Landing.ViewModel) {
        print("state is \(viewModel)")
        self.currentOption = viewModel.option
        renderAuthOption(option: viewModel.option)
        _ = viewModel.loading ? showLoading() : hideLoading()
        viewModel.error.flatMap { err in
            self.presentError(error: err, actions: [
                UIAlertAction(title: "Ok", style: .cancel, handler: self.handler.errorOkTap)
                ])
        }
    }

    fileprivate func renderAuthOption(option: Landing.ViewModel.Option) {
        let wordedOption: String
        let oppositeWordedOption: String
        let helperTitle: String
        switch option {
        case .login:
            wordedOption = tr(key: .LoginLandingLoginTitle)
            oppositeWordedOption = tr(key: .LoginLandingRegisterTitle)
            helperTitle = tr(key: .LoginLandingHelperLoginTitle)
        case .register:
            wordedOption = tr(key: .LoginLandingRegisterTitle)
            oppositeWordedOption = tr(key: .LoginLandingLoginTitle)
            helperTitle = tr(key: .LoginLandingHelperRegisterTitle)
        }

        self.interface.formContainer.layoutIfNeeded()

        self.interface.formHeader.text = tr(key: L10n.LoginLandingEmailbuttonTitle(wordedOption))
        self.interface.usernameField.isHidden = option == .login
        self.interface.actionButton.setTitle(title: wordedOption)
        self.interface.helperButton.setTitle(title: oppositeWordedOption)
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
        attributedString.addAttributes([NSForegroundColorAttributeName: UIColor(named: .LoginLandingBackround)], range: range)
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

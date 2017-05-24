import UIKit
import Library
import RxSwift
import RxCocoa
import SwiftyAttributes
import ReSwift

extension Landing {
    typealias ViewController = LandingViewController
}

class LandingViewController: UIViewController {
    @IBOutlet weak var subtitle: UILabel! {
        didSet { subtitle.text = tr(.loginLandingSubtitle) }
    }
    @IBOutlet weak var formContainer: UIStackView! {
        didSet { formContainer.addEdgePadding() }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet { titleLabel.text = tr(.loginLandingSocialButtonTitle) }
    }
    @IBOutlet weak var facebookButton: RoundedRenderedImageButton! {
        didSet {
            facebookButton.imageView!.contentMode = .scaleAspectFit

            let color = Color(named: .facebookBlue)
            facebookButton.tintColor = color

            facebookButton.layer.borderWidth = 1
            facebookButton.layer.borderColor = color.cgColor

        }
    }
    @IBOutlet weak var twitterButton: RoundedButton! {
        didSet {
            twitterButton.imageView!.contentMode = .scaleAspectFit

            let color = Color(named: .twitterBlue)
            twitterButton.tintColor = color

            twitterButton.layer.borderWidth = 1
            twitterButton.layer.borderColor = color.cgColor
        }
    }

    @IBOutlet weak var formHeader: UILabel!
    @IBOutlet weak var usernameField: InsettableTextField! {
        didSet { usernameField.configure() }
    }
    @IBOutlet weak var emailField: InsettableTextField! {
        didSet { emailField.configure() }
    }
    @IBOutlet weak var passwordField: InsettableTextField! {
        didSet { passwordField.configure() }
    }

    @IBOutlet weak var termsOfServiceButton: UIButton! {
        didSet {
            let prefix = tr(.loginLandingButtonTosTitlePrefix)
            let buttonText = tr(.loginLandingButtonTosTitleButton)
            let suffix = tr(.loginLandingButtonTosTitleSuffix)

            let textColor = termsOfServiceButton.currentTitleColor

            let attributedString = prefix.withTextColor(textColor) + buttonText.withTextColor(UIColor(named: .tint)) + suffix.withTextColor(textColor)

            termsOfServiceButton.titleLabel!.lineBreakMode = .byWordWrapping
            termsOfServiceButton.setAttributedTitle(attributedString, for: .normal)
        }
    }

    @IBOutlet weak var actionButton: RoundedButton!

    @IBOutlet weak var helperLabel: UILabel!
    @IBOutlet weak var helperButton: RoundedButton! {
        didSet {
            helperButton.layer.borderColor = UIColor(named: .tint).cgColor
            helperButton.layer.borderWidth = 1
        }
    }

    var controller: Landing.Controller!
    let dismissErrorSink = PublishSubject<Void>()
}

extension Landing.ViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = App.State

    override func viewDidLoad() {
        super.viewDidLoad()

        self.controller = Landing.Controller(
            input: (
                button: (
                    facebook: facebookButton.rx.tap,
                    twitter: twitterButton.rx.tap,
                    action: actionButton.rx.tap,
                    switchOption: helperButton.rx.tap,
                    dismissError: dismissErrorSink.asDriver(onErrorJustReturn: ())
                ),
                text: (
                    username: usernameField.rx.text,
                    email: emailField.rx.text,
                    password: passwordField.rx.text
                )
            )
        )

    }

    func newState(state: App.State) {
        render(option: state.landingState.option, animated: true)
        render(authLoadingState: state.authenticationState)
    }

    private func render(option: Landing.State.Option, animated: Bool) {
        formContainer?.layoutIfNeeded()
        defer {
            if animated {
                UIView.animate(withDuration: 0.2) { [weak self] in
                    self?.formContainer?.layoutIfNeeded()
                }
            } else {
                self.formContainer?.layoutIfNeeded()
            }
        }

        formHeader?.text = tr(.loginLandingEmailbuttonTitle(option.worded))
        usernameField?.isHidden = option == .login
        actionButton?.set(title: option.worded)
        helperButton?.set(title: option.other.worded)
        helperLabel?.text = option.helperText
    }

    private func render(authLoadingState: Authentication.State) {
        switch authLoadingState {
        case .loggingIn:
            startLoading(.gray)

        case .failedToLogin(let err):
            stopLoading()
            let errorAlert = UIAlertController(title: err.title, message: err.description, preferredStyle: .alert).then { errorAlert in
                errorAlert.addAction(UIAlertAction(title: tr(.errorDefaultOk), style: .cancel, handler: { [weak self] in
                    self!.dismissErrorSink.onNext(())
                }))
            }
            self.present(errorAlert, animated: true, completion: .none)

        case .loggedOut:
            stopLoading()

        case .loggedIn:
            stopLoading()
        }
    }
}

extension Landing.ViewController {
    static func fromStoryboard(authOption: Landing.State.Option) -> LandingViewController {
        return StoryboardScene.Landing.instantiateLanding()
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

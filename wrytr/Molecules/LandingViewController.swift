import UIKit
import RxSwift
import RxCocoa
import Library
import RxLibrary
import Cordux

extension Landing {
    typealias ViewController = LandingViewController
}

class LandingViewController: RxViewController {
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
        didSet { usernameField.configure() }
    }
    @IBOutlet weak var passwordField: InsettableTextField! {
        didSet { usernameField.configure() }
    }

    @IBOutlet weak var termsOfServiceButton: UIButton! {
        didSet {
            let title = tr(.loginLandingButtonTosTitle)
            let buttonRange = NSRange(ofString: "Terms & Privacy Policy", inString: title)

            let attributedString = NSMutableAttributedString(string: title)
            attributedString.addAttributes([NSForegroundColorAttributeName: UIColor(named: .tint)], range: buttonRange)
            termsOfServiceButton.setAttributedTitle(attributedString, for: .normal)

            termsOfServiceButton.titleLabel!.lineBreakMode = .byWordWrapping
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
}

extension Landing.ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension Landing.ViewController {
    static func fromStoryboard() -> LandingViewController {
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

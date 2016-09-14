import UIKit
import Library
import RxSwift
import UnderKeyboard

extension Compose {
    typealias ViewController = ComposeViewController
}

extension Compose.ViewController {
    static func fromStoryboard() -> ComposeViewController {
        return StoryboardScene.Compose.instantiateCompose()
    }
}

class ComposeViewController: InterfaceProvidingViewController {
    let keyboardObserver = UnderKeyboardObserver()

    var ui: UIType? // this is an antipattern, but I dont want do it right rn

    @IBOutlet weak var profileImageView: RoundedImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var challengeTextView: UITextView!
    @IBOutlet weak var characterCountLabel: UILabel!
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!

    struct IB: Primitive {
        let profile: RoundedImageView
        let username: UILabel
        let textView: UITextView
        let characterCount: UILabel
        let bottomConstraint: NSLayoutConstraint
    }

}

extension ComposeViewController {

    override func viewDidLoad() {
        self.interface = IB(
            profile: profileImageView,
            username: usernameLabel,
            textView: challengeTextView,
            characterCount: characterCountLabel,
            bottomConstraint: bottomLayoutConstraint
        )

        super.viewDidLoad()

        keyboardObserver.start()
        keyboardObserver.willAnimateKeyboard = { height in
            let isHidingKeyboard = height == 0

            let initialBottomPadding: CGFloat = 22
            let tabBarHeight: CGFloat = 49

            self.bottomLayoutConstraint.constant = isHidingKeyboard ? initialBottomPadding : height - tabBarHeight
        }
        keyboardObserver.animateKeyboard = { _ in self.view.layoutSubviews() }

    }

}

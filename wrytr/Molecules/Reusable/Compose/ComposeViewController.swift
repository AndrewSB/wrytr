import UIKit
import Library
import RxLibrary
import RxSwift
import RxCocoa
import UnderKeyboard

class Compose {
    typealias ViewController = ComposeViewController
}

class ComposeViewController: RxViewController {
    fileprivate static let characterLimit = App.Constants.composeCharacterCount
    fileprivate static let initialBottomPadding: CGFloat = 22
    fileprivate static let tabBarHeight: CGFloat = 49

    fileprivate let keyboardObserver = UnderKeyboardObserver()

    let postCreated = PublishSubject<String>()

    @IBOutlet weak var profileImageView: RoundedImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var challengeTextView: UITextView!
    @IBOutlet weak var characterCountLabel: UILabel!
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!

}

extension Compose.ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        keyboardObserver.start()
        keyboardObserver.willAnimateKeyboard = { height in
            let isHidingKeyboard = height == 0

            self.bottomLayoutConstraint.constant = isHidingKeyboard ? Compose.ViewController.initialBottomPadding : height - Compose.ViewController.tabBarHeight
        }
        keyboardObserver.animateKeyboard = { _ in self.view.layoutSubviews() }

        // update the character count label when the text changes
        challengeTextView.rx.textInput.text
            // get the count
            .map { text in text!.characters.count }
            // turn the count into an attributed string
            .map { count in
                let countColor: UIColor = count >= Compose.ViewController.characterLimit ? .red : .gray
                let countString = generateAttributedString("\(count)", color: countColor)
                let limitString = generateAttributedString("/\(Compose.ViewController.characterLimit)", color: .black)
                countString.append(limitString)
                return countString
            }
            // update the label's size
            .do(onNext: { [weak self] _ in self!.characterCountLabel.sizeToFit() })
            // bind it to the label's text
            .bind(to: self.characterCountLabel.rx.attributedText)
            .addDisposableTo(disposeBag)

        // whenever you hit enter, create a post
        challengeTextView.rx.didEndEditing
            // grab the text
            .map { [weak self] _ in self!.challengeTextView.text! }
            // create a post
            .bind(to: postCreated)
            .addDisposableTo(disposeBag)

        challengeTextView.rx.delegate.setForwardToDelegate(DismissOnReturnTextViewDelegate(), retainDelegate: true)
    }

}

extension Compose.ViewController {
    static func fromStoryboard() -> ComposeViewController {
        return StoryboardScene.Compose.instantiateCompose()
    }
}

fileprivate func generateAttributedString(_ string: String, color: UIColor) -> NSMutableAttributedString {
    let attributedString = NSAttributedString(string: string, attributes: [NSForegroundColorAttributeName: color])

    return NSMutableAttributedString(attributedString: attributedString)
}

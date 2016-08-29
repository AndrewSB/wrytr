import UIKit
import Library
import RxSwift

protocol ComposeViewControllerDelegate {
    func shouldPost(post: Post)
}

class ComposeViewController: RxViewController {
    
    var delegate: ComposeViewControllerDelegate!
    var characterLimit = 150
    
    let keyboardObserver = KeyboardObserver()

    @IBOutlet weak var profileImageView: RoundedImageView! {
        didSet { _ = User.local.profilePictureNSUrl.flatMap { profileImageView.hnk_setImageFromURL($0) } }
    }
    @IBOutlet weak var usernameLabel: UILabel! {
        didSet { usernameLabel.text = User.local.authData.name }
    }
    @IBOutlet weak var challengeTextView: UITextView! {
        didSet { challengeTextView.delegate = self }
    }
    
    @IBOutlet weak var characterCountLabel: UILabel!
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!

}

extension ComposeViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handleText(addDisposablesTo: disposeBag)
        handleKeyboard(addDisposablesTo: disposeBag)
    }
    
}

private typealias KeyboardHandler = ComposeViewController
extension KeyboardHandler {
    
    private enum KeyboardState {
        case Hiding
        case Showing
    }
    
    private func handleKeyboard(addDisposablesTo disposeBag: DisposeBag) {
        keyboardObserver.willShow
            .map { (.Showing, $0) }
            .subscribeNext(animateKeyboardChange)
            .addDisposableTo(disposeBag)
        
        keyboardObserver.willHide
            .map { (.Hiding, $0) }
            .subscribeNext(animateKeyboardChange)
            .addDisposableTo(disposeBag)
    }
    
    private func animateKeyboardChange(keyboardState: KeyboardState, keyboardInfo: KeyboardObserver.KeyboardInfo) {
        let padding: CGFloat = 11
        let defaultKeyboardSize: CGFloat = 250
        
        let convertedKeyboardEndFrame = view.convertRect(keyboardInfo.frameEnd, fromView: view.window)
        let keyboardSize = CGRectGetMaxY(self.view.bounds) - CGRectGetMinY(convertedKeyboardEndFrame)
        
        var offsetAmount: CGFloat
        
        // handle 3rd party keyboards with no keyboard size
        if keyboardState == .Showing && keyboardSize == 0 {
            offsetAmount = defaultKeyboardSize + padding
        } else if keyboardState == .Hiding {
            offsetAmount = padding
        } else {
            offsetAmount = keyboardSize + padding
        }
        
        bottomLayoutConstraint.constant = offsetAmount
        print("animating \(bottomLayoutConstraint.constant)")
        
        UIView.animateWithDuration(keyboardInfo.animationDuration, delay: 0.0, options: [.BeginFromCurrentState, keyboardInfo.animationCurve], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)

    }
    
}

private typealias TextHandler = ComposeViewController
extension TextHandler {
    
    private func handleText(addDisposablesTo disposeBag: DisposeBag) {
        let attributedCharacterLimitString = generateAttributedString("/\(characterLimit)", color: .blackColor())
        
        challengeTextView.rx_text
            .subscribeNext { _ in self.characterCountLabel.sizeToFit() }
            .addDisposableTo(disposeBag)
        
        challengeTextView.rx_text
            .map { text in text.characters.count }
            .map { count in
                let countColor: UIColor = count >= self.characterLimit ? .redColor() : .grayColor()
                let countString = generateAttributedString("\(count)", color: countColor)
                countString.appendAttributedString(attributedCharacterLimitString)
                return countString
            }
            .bindTo(characterCountLabel.rx_attributedText)
            .addDisposableTo(disposeBag)
    }
    
}

extension ComposeViewController: UITextViewDelegate {
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            let text = textView.text
            textView.endEditing(true)
            self.postChallenge(Post(id: nil, userId: User.local.authData.id, prompt: text, stars: nil, comments: nil))
            return false
        } else {
            return true
        }
        
    }
    
    func postChallenge(post: Post) {
        delegate.shouldPost(post)
    }
    
}

private func generateAttributedString(string: String, color: UIColor) -> NSMutableAttributedString {
    let attributedString = NSAttributedString(string: string, attributes: [NSForegroundColorAttributeName: color])
    
    return attributedString.mutableCopy() as! NSMutableAttributedString
}
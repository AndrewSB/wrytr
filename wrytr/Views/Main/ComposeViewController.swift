import UIKit
import Library

protocol ComposeViewControllerDelegate {
    func shouldPost(post: Post)
}

class ComposeViewController: RxViewController {
    
    var delegate: ComposeViewControllerDelegate!
    var characterLimit = 150

    @IBOutlet weak var profileImageView: RoundedImageView! {
        didSet { profileImageView.hnk_setImageFromURL(User.local.profilePictureNSUrl) }
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

        KeyboardObserver().willShow
            .subscribeNext { _ in print("SHOW SEX")}
            .addDisposableTo(disposeBag)
        
        KeyboardObserver().willHide
            .subscribeNext { _ in print("HIDE SEX")}
            .addDisposableTo(disposeBag)
    }
    
}

private typealias KeyboardHandler = ComposeViewController
extension KeyboardHandler {
    
    
    private func animateKeyboardChange(keyboardInfo: KeyboardObserver.KeyboardInfo) {
        
        let convertedKeyboardEndFrame = view.convertRect(keyboardInfo.frameEnd, fromView: view.window)
        
        bottomLayoutConstraint.constant = CGRectGetMaxY(self.view.bounds) - CGRectGetMinY(convertedKeyboardEndFrame)
        
        print("animating \(bottomLayoutConstraint.constant)")
        
        UIView.animateWithDuration(keyboardInfo.animationDuration, delay: 0.0, options: [.BeginFromCurrentState, keyboardInfo.animationCurve], animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
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
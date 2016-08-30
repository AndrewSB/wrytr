import UIKit
import Library
import RxSwift

protocol ComposeViewControllerDelegate {
    func shouldPost(_ post: Post)
}

class ComposeViewController: RxViewController {
    
    var delegate: ComposeViewControllerDelegate!
    var characterLimit = 150
    
    let keyboardObserver = KeyboardObserver()

    @IBOutlet weak var profileImageView: RoundedImageView! {
        didSet { _ = User.local.profilePictureNSUrl.flatMap { profileImageView.pin_setImage(from: $0) } }
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
    
    fileprivate enum KeyboardState {
        case hiding
        case showing
    }
    
    fileprivate func handleKeyboard(addDisposablesTo disposeBag: DisposeBag) {
        keyboardObserver.willShow
            .subscribe(onNext: { self.animateKeyboardChange(keyboardState: .showing, keyboardInfo: $0) })
            .addDisposableTo(disposeBag)
        
        keyboardObserver.willHide
            .subscribe(onNext: { self.animateKeyboardChange(keyboardState: .hiding, keyboardInfo: $0) })
            .addDisposableTo(disposeBag)
    }
    
    fileprivate func animateKeyboardChange(keyboardState: KeyboardState, keyboardInfo: KeyboardObserver.KeyboardInfo) {
        let padding: CGFloat = 11
        let defaultKeyboardSize: CGFloat = 250
        
        let convertedKeyboardEndFrame = view.convert(keyboardInfo.frameEnd, from: view.window)
        let keyboardSize = self.view.bounds.maxY - convertedKeyboardEndFrame.minY
        
        var offsetAmount: CGFloat
        
        // handle 3rd party keyboards with no keyboard size
        if keyboardState == .showing && keyboardSize == 0 {
            offsetAmount = defaultKeyboardSize + padding
        } else if keyboardState == .hiding {
            offsetAmount = padding
        } else {
            offsetAmount = keyboardSize + padding
        }
        
        bottomLayoutConstraint.constant = offsetAmount
        print("animating \(bottomLayoutConstraint.constant)")
        
        UIView.animate(withDuration: keyboardInfo.animationDuration, delay: 0.0, options: [.beginFromCurrentState, keyboardInfo.animationCurve], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)

    }
    
}

private typealias TextHandler = ComposeViewController
extension TextHandler {
    
    fileprivate func handleText(addDisposablesTo disposeBag: DisposeBag) {
        let attributedCharacterLimitString = generateAttributedString("/\(characterLimit)", color: .black)
        
        challengeTextView.rx.textInput.text
            .subscribe(onNext: { _ in self.characterCountLabel.sizeToFit() })
            .addDisposableTo(disposeBag)
        
        challengeTextView.rx.textInput.text
            .map { text in text.characters.count }
            .map { count in
                let countColor: UIColor = count >= self.characterLimit ? .red : .gray
                let countString = generateAttributedString("\(count)", color: countColor)
                countString.append(attributedCharacterLimitString)
                return countString
            }
            .bindTo(characterCountLabel.rx.attributedText)
            .addDisposableTo(disposeBag)
    }
    
}

extension ComposeViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            let text = textView.text
            textView.endEditing(true)
            self.postChallenge(Post(id: nil, userId: User.local.authData.id, prompt: text!, stars: nil, comments: nil))
            return false
        } else {
            return true
        }
        
    }
    
    func postChallenge(_ post: Post) {
        delegate.shouldPost(post)
    }
    
}

private func generateAttributedString(_ string: String, color: UIColor) -> NSMutableAttributedString {
    let attributedString = NSAttributedString(string: string, attributes: [NSForegroundColorAttributeName: color])
    
    return attributedString.mutableCopy() as! NSMutableAttributedString
}

import UIKit
import Library

class ComposeViewController: UIViewController {

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
        store.dispatch(LocalPostReady(post: post))
        store.dispatch(CreatePostProvider.uploadPost)
    }
    
}
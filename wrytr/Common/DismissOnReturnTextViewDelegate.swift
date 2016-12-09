import UIKit

class DismissOnReturnTextViewDelegate: NSObject, UITextViewDelegate {

    override init() {

        super.init()
    }

    deinit {

    }

    //swiftlint:disable:next variable_name
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        } else {
            return true
        }
    }
}

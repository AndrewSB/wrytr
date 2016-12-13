import UIKit

class DismissOnReturnTextViewDelegate: NSObject, UITextViewDelegate {

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

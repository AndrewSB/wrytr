import UIKit

extension UIAlertAction {
    convenience init(title: String, style: UIAlertActionStyle, handler: @escaping () -> ()) {
        self.init(title: title, style: style, handler: { (_: UIAlertAction) -> Void in
            handler()
        })
    }
}

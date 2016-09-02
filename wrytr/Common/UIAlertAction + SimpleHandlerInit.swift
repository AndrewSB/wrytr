import UIKit

extension UIAlertAction {
    convenience init(title: String, style: UIAlertActionStyle, handler: () -> ()) {
        self.init(title: title, style: style, handler: { _ in
            handler()
        })
    }
}

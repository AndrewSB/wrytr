import UIKit
import RxSwift

extension Feed {
    class UI: UIType {
        weak internal var viewController: UIViewController?

        internal var bindings: [Disposable]

        
        init() {
            self.bindings = []
        }
        
    }
}

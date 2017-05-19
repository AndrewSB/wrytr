import UIKit

class RootNavigator: MainNavigation {
    var child: MainNavigation?

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func add(child: ChildNavigation) {
        self.child = child
        child.presentationContext = { [weak self] childView in
            self!.rootViewController.present(childView, animated: false)
        }
    }
}

import UIKit

class RootNavigator: MainNavigation {
    var child: ChildNavigation?

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func add(child: ChildNavigation) {
        self.child = child
        self.child!.presentationContext = { [weak self] childView in
            self!.window.rootViewController!.present(childView, animated: false)
        }
    }

    func activate(routable: Routable) {
        guard let leafChild = self.recursiveLastChild as? ChildNavigation else {
            fatalError("what must a root navigator do without a child?")
        }

        leafChild.activate(routable: routable)
    }
}

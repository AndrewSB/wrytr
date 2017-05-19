import UIKit

class Authentication {
    class Navigator: ChildNavigation {
        var child: MainNavigation? = .none

        var presentationContext: ((UIViewController) -> Void)!

        var activated: Routable?

        func configure(with routables: [Routable]) {
            fatalError("no-op")
        }

        func activate(routable: Routable) {
            presentationContext(routable.rootViewController)
        }

        func add(child: ChildNavigation) {
            self.child = child
            child.presentationContext = { [weak self] childView in
                self!.activated!.rootViewController.present(childView, animated: false)
            }
        }

    }
}

import UIKit

class Home {
    class Navigator: ChildNavigation {
        var child: ChildNavigation?

        var presentationContext: ((UIViewController) -> Void)!

        private let tabBarController = UITabBarController()
        func configure(with routables: [Routable]) {
            tabBarController.viewControllers = routables.map { $0.rootViewController }
        }

        init() {}


            tabBarController.selectedIndex = indexToActivate
        }

        func add(child: ChildNavigation) {
            fatalError("unimplemented")
        }
    }
}

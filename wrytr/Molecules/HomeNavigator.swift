import UIKit

class Home {
    class Navigator: ChildNavigation {
        var child: MainNavigation?

        let tabBarController = UITabBarController()

        func configure(with routables: [Routable]) {
            tabBarController.viewControllers = routables.map { $0.rootViewController }
        }

        func activate(routable: Routable) {
            let childToBeActivated = tabBarController.viewControllers!.enumerated()
                .filter { _, vc in vc == routable.rootViewController } // swiftlint:disable:this identifier_name
                .first

            guard let indexToActivate = childToBeActivated?.offset else { fatalError("programmer error") }

            tabBarController.selectedIndex = indexToActivate
        }

        func add(child: ChildNavigation) {
            fatalError("unimplemented")
        }
    }
}

import UIKit
import Then

class Home {
    class Navigator: ChildNavigation {
        var child: ChildNavigation?

        var presentationContext: ((UIViewController) -> Void)!
        private lazy var tabBarController: UITabBarController = UITabBarController().then {
            let routables: [Routable] = [
                self.modules.feed,
                self.modules.friends,
                self.modules.create,
                self.modules.me
            ]

            $0.viewControllers = routables.map { $0.rootViewController }
        }

        let modules = (
            feed: Feed.Module(),
            friends: Friends.Module(),
            create: Create.Module(),
            me: Me.Module()
        )

        func activate(route: AppRoute) {
            self.presentationContext(self.tabBarController)

            guard case let .home(homeRoute) = route else {
                fatalError("unimplemented for non-home routes")
            }

            tabBarController.selectedIndex = {
                switch homeRoute {
                case .feed:
                    return 0
                case .friends:
                    return 1
                case .create:
                    return 2
                case .me:
                    return 3
                }
            }()
        }

        func add(child: ChildNavigation) {
            fatalError("unimplemented")
        }
    }
}

import Cordux
import RxCocoa

class Home {}

extension Home {

    class Coordinator: NSObject, TabBarControllerCoordinator {
        enum RouteSegment: String, RouteConvertible {
            case feed
            case create
            case me

            func coordinator(withStore store: Store) -> AnyCoordinator {
                switch self {
                case .feed:
                    return Feed.Coordinator(store: store)
                case .create:
                    return Create.Coordinator(store: store)
                case .me:
                    return Feed.Coordinator(store: store)
                }
            }

            var tabBarItem: UITabBarItem {
                switch self {
                case .feed:
                    return UITabBarItem(title: tr(.feedTitle), image: #imageLiteral(resourceName: "icon-tabbar-feed"), tag: 0)
                case .create:
                    return UITabBarItem(title: tr(.createTitle), image: #imageLiteral(resourceName: "icon-tabbar-create"), tag: 0)
                case .me:
                    return UITabBarItem(title: tr(.meTitle), image: #imageLiteral(resourceName: "icon-tabbar-profile"), tag: 0)
                }
            }
        }

        let store: Store

        let scenes: [Scene]
        let tabBarController = UITabBarController()

        init(store: Store) {
            self.store = store
            self.scenes = [RouteSegment.feed, RouteSegment.create].map { route in
                Scene(prefix: route.rawValue, coordinator: route.coordinator(withStore: store))
            }
            super.init()

            self.tabBarController.delegate = self
            self.tabBarController.viewControllers = self.scenes.map { $0.coordinator.rootViewController }
        }
    }

}

extension Home.Coordinator {
    func start(route: Route?) {

    }
}

extension Home.Coordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return setRouteForViewController(viewController)
    }
}

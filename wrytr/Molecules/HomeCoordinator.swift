import Cordux
import RxCocoa

class Home {}

extension Home {

    class Coordinator: NSObject, TabBarControllerCoordinator {
        enum RouteSegment: String, RouteConvertible {
            case feed
            case friends
            case create
            case me

            static var allValues: [Home.Coordinator.RouteSegment] {
                return [.feed, .friends, .create, .me]
            }

            func coordinator(withStore store: Store) -> AnyCoordinator {
                return Feed.Coordinator(store: store)
            }
        }

        let store: Store

        let scenes: [Scene]
        let tabBarController = UITabBarController()

        init(store: Store, segments: [RouteSegment] = RouteSegment.allValues) {
            self.store = store
//            self.scenes = segments.map { route in
//                Scene(prefix: route.rawValue, coordinator: route.coordinator(withStore: store))
//            }
            self.scenes = [Scene(prefix: RouteSegment.feed.rawValue, coordinator: RouteSegment.feed.coordinator(withStore: store))]
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

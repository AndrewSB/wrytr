import Cordux
import RxCocoa
import Then

class Home {}

extension Home {

    class Coordinator: NSObject, TabBarControllerCoordinator {
        enum RouteSegment: String, RouteConvertible {
            case feed
            case friends
            case create
            case me

            func coordinator(withStore store: Cordux.Store<App.State>) -> AnyCoordinator {
                switch self {
                case .feed:
                    return Feed.Coordinator(store: store)
                case .friends:
                    return Friends.Coordinator(store: store)
                case .create:
                    return Create.Coordinator(store: store)
                case .me:
                    return Me.Coordinator(store: store)
                }
            }
        }

        let store: Cordux.Store<App.State>

        let scenes: [Scene]
        let tabBarController = UITabBarController()

        init(store: Cordux.Store<App.State>) {
            self.store = store
            self.scenes = [RouteSegment.feed, RouteSegment.friends, RouteSegment.create, RouteSegment.me].map { route in
                Scene(prefix: route.rawValue, coordinator: route.coordinator(withStore: store))
            }
            super.init()

            self.tabBarController.delegate = self
            self.tabBarController.viewControllers = self.scenes.map { scene in
                scene.coordinator.rootViewController
            }
        }
    }

}

extension Home.Coordinator {
    func start(route: Route?) {}
}

extension Home.Coordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return setRouteForViewController(viewController)
    }
}

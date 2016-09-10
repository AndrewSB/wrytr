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
        }

        let store: Store

        let scenes: [Scene]
        let tabBarController = UITabBarController()

        init(store: Store, scenes: [Scene] = RouteSegment.allScenes) {
            self.store = store
            self.scenes = scenes
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


fileprivate extension Home.Coordinator.RouteSegment {
    static var allValues: [Home.Coordinator.RouteSegment] {
        return [.feed, .friends, .create, .me]
    }

    static var allScenes: [Scene] {
        return []
    }
}

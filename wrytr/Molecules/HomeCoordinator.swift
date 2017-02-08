import Cordux
import RxCocoa
import Then

protocol TabBarItemProviding: class {
    static var tabItem: UITabBarItem { get }
    var tabBarItem: UITabBarItem! { get set }
}

class Home {

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

        lazy var sceneForRoute: (Route) -> Scene? = { route in
            route.first.flatMap(RouteSegment.init).map {
                switch $0 {
                case .feed:     return self.scenes[0]
                case .friends:     return self.scenes[1]
                case .create:     return self.scenes[2]
                case .me:     return self.scenes[3]
                }
            }
        }
        let scenes: [Scene]
        let tabBarController = UITabBarController()

        init(store: Cordux.Store<App.State>) {
            self.store = store

            let sceneRoutes: [RouteSegment] = [.feed, .friends, .create, .me]
            self.scenes = sceneRoutes.map { route in
                Scene(prefix: route.rawValue, coordinator: route.coordinator(withStore: store))
            }

            super.init()

            self.tabBarController.delegate = self
            self.tabBarController.viewControllers = self.scenes.map { scene in
                let vc = scene.coordinator.rootViewController
                guard let tabBarVC = scene.coordinator.rootViewController.unwrapNavCon() as? TabBarItemProviding else { fatalError() }
                vc.tabBarItem = type(of: tabBarVC).tabItem
                return vc
            }
        }
    }

}

extension Home.Coordinator {
    func start(route: Route?) {
        guard let route = route, !route.isEmpty else {
            return self.store.route(.push(RouteSegment.feed))
        }
    }

    /// This is called each time the store is dispatched programatically 
    func changeScene(_ route: Route) {
        print("change scene to \(route). self is \(self.route). Parent is \(appStore.state.route)")
    }

}

extension Home.Coordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return setRouteForViewController(viewController)
    }
}

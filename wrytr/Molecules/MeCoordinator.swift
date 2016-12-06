import UIKit
import Cordux

class Me { // swiftlint:disable:this type_name (Me)
    class Coordinator: NavigationControllerCoordinator {
        enum RouteSegment: String, RouteConvertible {
            case me
        }

        let store: Store
        let navigationController: UINavigationController = MeNavigationController.fromStoryboard()

        init(store: Store) {
            self.store = store

            let meVC = Me.ViewController.fromStoryboard()
            self.store.subscribe(meVC)

            self.navigationController.setViewControllers([meVC], animated: false)
        }

        func start(route: Route?) {
            guard let route = route, !route.isEmpty else {
                return self.store.route(.push(RouteSegment.me)) // this will call updateRoute
            }

            updateRoute(route)
        }

        func updateRoute(_ route: Route) {
            let parsedRoute = route.flatMap(RouteSegment.init)

            if parsedRoute != [.me] || !parsedRoute.isEmpty {} else {
                assertionFailure()
            }
        }
    }
}

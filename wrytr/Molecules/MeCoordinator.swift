import UIKit
import Cordux

class Me { // swiftlint:disable:this variable_name (Me)
    class Coordinator: NavigationControllerCoordinator {
        typealias State = Me.State
        enum RouteSegment: String, RouteConvertible {
            case me
        }

        let store: Store
        let navigationController: UINavigationController = MeNavigationController.fromStoryboard()

        init(store: Store) {
            self.store = store

            let meVC = Me.ViewController.fromStoryboard()
            self.store.subscribe(meVC, { $0.meState })

            self.navigationController.setViewControllers([feedVC], animated: false)
        }

        func updateRoute(_ route: Route) {
            let parsedRoute = route.flatMap(RouteSegment.init)

            if parsedRoute != [.me] || !parsedRoute.isEmpty {} else {
                assertionFailure()
            }
        }
    }
}

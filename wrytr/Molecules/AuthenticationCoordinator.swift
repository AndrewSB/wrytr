import Cordux
import Then

class Authentication {}

extension Authentication {

    class Coordinator: NavigationControllerCoordinator {
        enum RouteSegment: String, RouteConvertible {
            case landing
        }

        let store: Store

        let navigationController = UINavigationController().then {
            $0.isNavigationBarHidden = true
        }

        init(store: Store) {
            self.store = store

            let landingVC = Landing.make(withRouteSegment: RouteSegment.landing, store: self.store)
            self.navigationController.setViewControllers([landingVC], animated: false)
        }

        func start(route: Route?) {
            guard let route = route, !route.isEmpty else {
                return self.store.route(.push(RouteSegment.landing)) // this will call updateRoute
            }

            updateRoute(route)
        }

        func updateRoute(_ route: Route) {
            let parsedRoute = route.flatMap(RouteSegment.init)

            if parsedRoute != [.landing] || !parsedRoute.isEmpty {} else {
                assertionFailure()
            }
        }


    }

}

import Cordux

class Create {

    class Coordinator: NavigationControllerCoordinator {
        enum RouteSegment: String, RouteConvertible {
            case create
        }

        let store: Cordux.Store<App.State>

        let navigationController: UINavigationController = CreateNavigationController.fromStoryboard()

        init(store: Cordux.Store<App.State>) {
            self.store = store

            let createVC = Create.ViewController.fromStoryboard()
            store.subscribe(createVC)
            self.navigationController.setViewControllers([createVC], animated: false)
        }

        func start(route: Route?) {
            guard let route = route, !route.isEmpty else {
                return self.store.route(.push(RouteSegment.create))
            }

            updateRoute(route) {}
        }

        func updateRoute(_ route: Route, completionHandler: @escaping () -> Void) {            let parsedRoute = route.flatMap(RouteSegment.init)

            if parsedRoute != [.create] || !parsedRoute.isEmpty {} else {
                assertionFailure()
            }

            completionHandler()
        }
    }

}

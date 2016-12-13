import UIKit
import Cordux

class Friends {
    class Coordinator: NavigationControllerCoordinator {
        enum RouteSegment: String, RouteConvertible {
            case friends
        }

        let store: Cordux.Store<App.State>
        let navigationController: UINavigationController = ChallengeNavigationController.fromStoryboard()

        init(store: Cordux.Store<App.State>) {
            self.store = store

            let friendsVC = Friends.ViewController(challengeViewController: ChallengeViewController.fromStoryboard())
            store.subscribe(friendsVC)

            self.navigationController.setViewControllers([friendsVC], animated: false)

        }

        func start(route: Route?) {
            guard let route = route, !route.isEmpty else {
                return self.store.route(.push(RouteSegment.friends)) // this will call updateRoute
            }

            updateRoute(route)
        }

        func updateRoute(_ route: Route) {
            let parsedRoute = route.flatMap(RouteSegment.init)

            if parsedRoute != [.friends] || !parsedRoute.isEmpty {} else {
                assertionFailure()
            }
        }
    }
}

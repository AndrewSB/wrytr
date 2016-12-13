import UIKit
import Cordux

class Feed {

    class Coordinator: NavigationControllerCoordinator {
        typealias State = App.State
        enum RouteSegment: String, RouteConvertible {
            case feed
        }

        let store: Cordux.Store<App.State>
        let navigationController: UINavigationController = ChallengeNavigationController.fromStoryboard()

        init(store: Cordux.Store<App.State>) {
            self.store = store

            let feedVC = Feed.ViewController(challengeViewController: ChallengeViewController.fromStoryboard())
            store.subscribe(feedVC)

            self.navigationController.setViewControllers([feedVC], animated: false)
        }

        func start(route: Route?) {
            guard let route = route, !route.isEmpty else {
                return self.store.route(.push(RouteSegment.feed)) // this will call updateRoute
            }

            updateRoute(route)
        }

        func updateRoute(_ route: Route) {
            let parsedRoute = route.flatMap(RouteSegment.init)

            if parsedRoute != [.feed] || !parsedRoute.isEmpty {} else {
                assertionFailure()
            }
        }
    }

}

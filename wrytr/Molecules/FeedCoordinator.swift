import UIKit
import Cordux

class Feed {

    class Coordinator: NavigationControllerCoordinator {
        enum RouteSegment: String, RouteConvertible {
            case feed
        }

        let navigationController: UINavigationController = FeedNavigationController.fromStoryboard()

        init(store: Store) {
            self.store = store

            let feedVC = Feed.ViewController.fromStoryboard()
            store.subscribe(feedVC, { $0.feedState })

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

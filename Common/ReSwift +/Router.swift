import UIKit
import ReSwift

protocol Routable {
    var rootViewController: UIViewController { get }
    var route: AppRoute { get } /// This is perhaps not necessary
}

protocol MainNavigation: class {
    var child: ChildNavigation? { get set }

    func add(child: ChildNavigation)

    func activate(route: AppRoute)
}

protocol ChildNavigation: MainNavigation {
    /// navigate to route
    func activate(route: AppRoute)

    /// perhaps not the best abstraction, but a child can assume that after being configured by it's parent, context can be used to present itself
    var presentationContext: ((UIViewController) -> Void)! { get set }
}

extension MainNavigation {
    /// Iterates through all the children of provided `MainNavigation` and returns the leaf that has no child
    var recursiveLastChild: MainNavigation {
        switch child {
        case .none:
            return self
        case .some(let cursorChild):
            return cursorChild.recursiveLastChild
        }
    }
}

class Router: StoreSubscriber {
    let mainNavigation: MainNavigation

    var currentRoute: AppRoute?

    init(mainNavigation: MainNavigation) {
        self.mainNavigation = mainNavigation
    }

    func newState(state: AppRoute) {
        /// Bail out if the route hasn't changed
        guard state != currentRoute else {
            fatalError("reswift should be preventing this now. If not, investigate")
        }

        activate(route: state)
    }

    fileprivate func activate(route: AppRoute) {
        self.currentRoute = route
        mainNavigation.activate(route: route)
    }
}

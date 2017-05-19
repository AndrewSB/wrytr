import UIKit
import ReSwift

public protocol Routable {
    var rootViewController: UIViewController { get }
    var route: AppRoute { get }
}

public protocol MainNavigation {
    var child: MainNavigation? { get }

    func add(child: ChildNavigation)
}

public protocol ChildNavigation: MainNavigation {
    /// add these routes as children
    func configure(with routables: [Routable])

    /// navigate to route
    func activate(routable: Routable)

    /// perhaps not the best abstraction, but a child can assume that after being configured by it's parent, context can be used to present itself
    var presentationContext: ((UIViewController) -> Void)! { get set }
}

private extension MainNavigation {
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

public class Router: StoreSubscriber {

    let mainNavigation: MainNavigation
    let configuration: RouterConfiguration

    var currentRoute: AppRoute?

    public init(
        mainNavigation: MainNavigation,
        configuration: RouterConfiguration) {

        self.mainNavigation = mainNavigation
        self.configuration = configuration
    }

    public func newState(state: AppRoute?) {

        guard let route = state,
            route != currentRoute
            else { return }

        activate(route: route)
    }

    fileprivate func activate(route: AppRoute) {
        self.currentRoute = route

        let routable = configuration.routable(for: route)
        mainNavigation.activate(routable: routable)
    }
}

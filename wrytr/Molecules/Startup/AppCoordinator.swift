import UIKit
import Cordux

extension App {
    final class Coordinator: SceneCoordinator {
        enum RouteSegment: String, RouteConvertible {
            case auth // swiftlint:disable:this variable_name
            case home // swiftlint:disable:this variable_name
        }

        fileprivate var childCoordinatorsPresented: [RouteSegment: (AnyCoordinator, Bool)] = [:]

        let store: Cordux.Store<App.State>
        let container: UIViewController

        /// The current scene being shown by the coordinator.
        var currentScene: Scene? {
            didSet {
                print("set scene to \(String(describing: currentScene))")
            }
        }

        var rootViewController: UIViewController {
            return container
        }

        init(store: Cordux.Store<App.State>, container: UIViewController) {
            self.store = store
            self.container = container
        }

        func start(route: Route?) {
            store.rootCoordinator = self

            guard let route = route, !route.isEmpty else {
                let initialRouteSegment: RouteSegment = User.Service.isLoggedIn ? .home : .auth
                return store.route(.push(initialRouteSegment.route())) // this will call changeScene
            }

        }

        func presentCoordinator(_ coordinator: AnyCoordinator?, completionHandler: @escaping () -> Void) {
            guard let coordinator = coordinator else { fatalError() }

            let filtered = childCoordinatorsPresented.values
                .map { coordinator, _ in coordinator }
                .filter { coordinator.route == $0.route }
            guard filtered.count == 1 else { fatalError() }

            let new = filtered.first!
            let newRouteSegment = RouteSegment(rawValue: new.route.components.last!)!

            switch childCoordinatorsPresented[newRouteSegment]! {
            case (_, true):  break
            case (_, false):
                new.start(route: newRouteSegment.route())
                childCoordinatorsPresented[newRouteSegment]!.1 = true
            }

            switchView(inContainerView: self.container, from: current.rootViewController, to: new.rootViewController, completion: completionHandler)
        }

        // swiftlint:disable:next identifier_name
        func coordinatorForTag(_ tag: String) -> (coordinator: AnyCoordinator, started: Bool)? {
            guard let routeSegment = RouteSegment(rawValue: tag) else { return .none }

            switch routeSegment {
            case .auth:
                return (Authentication.Coordinator(store: self.store), false)
            case .home:
                return (Home.Coordinator(store: self.store), false)
            }
        }

    }
}

// this handles animating b/w .auth & .home
private typealias ContainerAnimator = App.Coordinator
private extension ContainerAnimator {
    func switchView(inContainerView container: UIViewController,
                    from fromVC: UIViewController?, // potentially nil, if youre setting the view for the first time
                    to toVC: UIViewController, // swiftlint:disable:this variable_name
                    completion: @escaping () -> Void) { // swiftlint:disable:this variable_name

        fromVC?.willMove(toParentViewController: nil)
        container.addChildViewController(toVC)
        container.view.addSubview(toVC.view)

        let constraints = [
            toVC.view.leftAnchor.constraint(equalTo: container.view.leftAnchor),
            toVC.view.rightAnchor.constraint(equalTo: container.view.rightAnchor),
            toVC.view.topAnchor.constraint(equalTo: container.view.topAnchor),
            toVC.view.bottomAnchor.constraint(equalTo: container.view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)

        toVC.view.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            fromVC?.view.alpha = 0
            toVC.view.alpha = 1
        }, completion: { _ in
            fromVC?.view.removeFromSuperview()
            fromVC?.removeFromParentViewController()
            toVC.didMove(toParentViewController: container)
            completion()
        })
    }
}

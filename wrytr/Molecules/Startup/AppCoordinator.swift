import UIKit
import Cordux

final class AppCoordinator: SceneCoordinator {
    enum RouteSegment: String, RouteConvertible {
        case auth
        case home
    }
    var scenePrefix: String?
    
    let store: Store
    let container: UIViewController

    var currentScene: AnyCoordinator?

    var rootViewController: UIViewController {
        return container
    }
    
    init(store: Store, container: UIViewController) {
        self.store = store
        self.container = container
    }
    
    func start(route: Route?) {
        store.rootCoordinator = self
        
        let initialRoute: RouteSegment = User.Service.isLoggedIn ? .home : .auth
        
        switch route {
        case .none:
            changeScene(initialRoute.route())
        case .some(let r) where r.count == 0:
            changeScene(initialRoute.route())
        case .some(let r):
            changeScene(r)
        }
    }
    
    func changeScene(_ route: Route) {
        guard let segment = RouteSegment(rawValue: route.first ?? "") else {
            return
        }
        
        let old = currentScene?.rootViewController
        let coordinator: AnyCoordinator
        coordinator = Authentication.Coordinator(store: store)
//        switch segment {
//        case .auth:
//            coordinator = AuthenticationCoordinator(store: store)
//        case .home:
//            coordinator = CatalogCoordinator(store: store)
//        }

//        let sceneRoute = Route(route.dropFirst()) // drop .auth or .home from the route that gets passed to the next scene
        coordinator.start(route: sceneRoute(route))
        self.currentScene = coordinator
        self.scenePrefix = segment.rawValue
        
        let new = coordinator.rootViewController
        switchView(inContainerView: self.container, from: old, to: new)
    }
    

}

// this handles animating b/w .auth & .home
private typealias ContainerAnimator = AppCoordinator
private extension ContainerAnimator {
    func switchView(inContainerView container: UIViewController,
                    from fromVC: UIViewController?, // potentially nil, if youre setting the view for the first time
                    to toVC: UIViewController) {
        
        fromVC?.willMove(toParentViewController: nil)
        container.addChildViewController(toVC)
        container.view.addSubview(toVC.view)
        
        NSLayoutConstraint.activate([
            toVC.view.leftAnchor.constraint(equalTo: container.view.leftAnchor),
            toVC.view.rightAnchor.constraint(equalTo: container.view.rightAnchor),
            toVC.view.topAnchor.constraint(equalTo: container.view.topAnchor),
            toVC.view.bottomAnchor.constraint(equalTo: container.view.bottomAnchor)
        ])
        
        toVC.view.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            fromVC?.view.alpha = 0
            toVC.view.alpha = 1
            }, completion: { _ in
                fromVC?.view.removeFromSuperview()
                fromVC?.removeFromParentViewController()
                toVC.didMove(toParentViewController: container)
        })
    }
}

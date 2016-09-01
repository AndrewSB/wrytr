import Cordux

class Authentication {}

extension Authentication {
    
    class Coordinator: NavigationControllerCoordinator {
        enum RouteSegment: String, RouteConvertible {
            case landing
        }
        
        let store: Store
        
        let navigationController = UINavigationController()
        
        init(store: Store) {
            self.store = store
            
            let landingVC = Landing.build(context: Context(RouteSegment.landing, lifecycleDelegate: self))
            self.navigationController.viewControllers = [landingVC]
        }
        
        func start(route: Route?) {
            switch route {
            case .none:
                self.store.setRoute(.push(RouteSegment.landing))
            case .some(let route) where route.count == 0:
                self.store.setRoute(.push(RouteSegment.landing))
            case .some(let route):
                assertionFailure("\(route)")
            }
        }
        
        func updateRoute(_ route: Route) {
            assertionFailure("need to update route?")
        }
        

    }
    
}

extension Authentication.Coordinator: ViewControllerLifecycleDelegate {
    @objc func viewDidLoad(viewController: UIViewController) {
        switch viewController {
        case let landingVC as LandingViewController:
            self.store.subscribe(landingVC) 
        default:
            assertionFailure()
        }
    }
    
    @objc func didMove(toParentViewController parentViewController: UIViewController?, viewController: UIViewController) {
        guard parentViewController == nil else {
            return
        }
        
        popRoute(viewController)
    }
}

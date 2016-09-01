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
        }
        
        func start(route: Route?) {
            guard let numberOfSegments = route?.count, numberOfSegments > 0 else {
                return store.setRoute(.push(RouteSegment.landing))
            }
        }
        
        func updateRoute(_ route: Route) {
            assertionFailure("need to update route?")
        }

    }
    
}

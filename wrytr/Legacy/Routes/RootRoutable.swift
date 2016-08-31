import UIKit

import ReSwift
import ReSwiftRouter

let landingRoute: RouteElementIdentifier = StoryboardScene.Login.LandingScene.rawValue
let mainRoute: RouteElementIdentifier = HomeTabBarController.identifier

class RootRoutable: Routable {
    
    let loginStoryboard = StoryboardScene.Login.storyboard()
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func setToLandingViewController() -> Routable {
        self.window.rootViewController = loginStoryboard.instantiateViewController(withIdentifier: landingRoute)
        
        return LoginViewRoutable(self.window.rootViewController!)
    }
    
    func setToMainViewController() -> Routable {
        self.window.rootViewController = HomeTabBarController()
        
        return self.window.rootViewController as! HomeTabBarController
    }
    
    func changeRouteSegment(_ from: RouteElementIdentifier, to: RouteElementIdentifier, animated: Bool, completionHandler: RoutingCompletionHandler) -> Routable {
        print("root is changing segment")
        
        if to == landingRoute {
            completionHandler()
            return self.setToLandingViewController()
        } else if to == mainRoute {
            completionHandler()
            return self.setToMainViewController()
        } else {
            fatalError("Route not supported!")
        }
    }
    
    func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: RoutingCompletionHandler) -> Routable {
        
        if routeElementIdentifier == landingRoute {
            completionHandler()
            return self.setToLandingViewController()
        } else if routeElementIdentifier == mainRoute {
            completionHandler()
            return self.setToMainViewController()
        } else {
            fatalError("Route not supported!")
        }
    }

}

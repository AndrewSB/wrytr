import UIKit

import ReSwift
import ReSwiftRouter

let signupRoute: RouteElementIdentifier = "\(StoryboardScene.Login.LandingScene.rawValue)signup"
let loginRoute: RouteElementIdentifier = "\(StoryboardScene.Login.LandingScene.rawValue)login"

class LoginViewRoutable: Routable {

    let viewController: UIViewController
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: RoutingCompletionHandler) -> Routable {
        
        switch routeElementIdentifier {
        case signupRoute:
            let signupVC = StoryboardScene.Login.LandingScene.viewController() as! LandingViewController
//            signupVC.type = .SignUp
            self.viewController.present(signupVC, animated: false, completion: completionHandler)
        case loginRoute:
            let loginVC = StoryboardScene.Login.LandingScene.viewController() as! LandingViewController
//            loginVC.type = .LogIn
            self.viewController.present(loginVC, animated: false, completion: completionHandler)
        default:
            assertionFailure()
        }
        
        return LandingRoutable()
    }
    
    func changeRouteSegment(_ from: RouteElementIdentifier, to: RouteElementIdentifier, animated: Bool, completionHandler: RoutingCompletionHandler) -> Routable {
        if to == mainRoute {
            return RootRoutable(window: UIApplication.shared.delegate!.window!!).setToMainViewController()
        } else {
            assertionFailure("bruh")
            return self
        }
    }

}

class LandingRoutable: Routable {

    func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: RoutingCompletionHandler) {
        print("is landing")
        completionHandler()
    }

}

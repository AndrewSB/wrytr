//
//  LoginViewRoutable.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 3/18/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

import ReSwift
import ReSwiftRouter

let signupRoute: RouteElementIdentifier = "\(StoryboardScene.Login.OnboardingScene.rawValue)signup"
let loginRoute: RouteElementIdentifier = "\(StoryboardScene.Login.OnboardingScene.rawValue)login"

class LoginViewRoutable: Routable {

    let viewController: UIViewController
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func pushRouteSegment(routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: RoutingCompletionHandler) -> Routable {
        
        switch routeElementIdentifier {
        case signupRoute:
            let signupVC = StoryboardScene.Login.OnboardingScene.viewController() as! OnboardingViewController
            signupVC.type = .SignUp
            self.viewController.presentViewController(signupVC, animated: false, completion: completionHandler)
        case loginRoute:
            let loginVC = StoryboardScene.Login.OnboardingScene.viewController() as! OnboardingViewController
            loginVC.type = .LogIn
            self.viewController.presentViewController(loginVC, animated: false, completion: completionHandler)
        default:
            assertionFailure()
        }
        
        return OnboardingRoutable()
    }
    
    func changeRouteSegment(from: RouteElementIdentifier, to: RouteElementIdentifier, animated: Bool, completionHandler: RoutingCompletionHandler) -> Routable {
        if to == mainRoute {
            return RootRoutable(window: UIApplication.sharedApplication().delegate!.window!!).setToMainViewController()
        } else {
            assertionFailure("bruh")
            return self
        }
    }

}

class OnboardingRoutable: Routable {}
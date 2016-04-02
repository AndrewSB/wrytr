//
//  RootRoutable.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 3/18/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

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
        self.window.rootViewController = loginStoryboard.instantiateViewControllerWithIdentifier(landingRoute)
        
        return LoginViewRoutable(self.window.rootViewController!)
    }
    
    func setToMainViewController() -> Routable {
        self.window.rootViewController = HomeTabBarController()
        
        return MainViewRoutable(self.window.rootViewController!)
    }
    
    func changeRouteSegment(from: RouteElementIdentifier, to: RouteElementIdentifier, animated: Bool, completionHandler: RoutingCompletionHandler) -> Routable {
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
    
    func pushRouteSegment(routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: RoutingCompletionHandler) -> Routable {
        
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

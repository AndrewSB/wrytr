//
//  HomeTabBarController.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/2/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

import ReSwift
import ReSwiftRouter

class HomeTabBarController: ReSwiftTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [
            StoryboardScene.Feed.initialViewController(),
            StoryboardScene.Friends.initialViewController(),
            StoryboardScene.Create.initialViewController(),
            StoryboardScene.Me.initialViewController()
        ]
        
        tabBar.autoresizesSubviews = false
        tabBar.clipsToBounds = true
    }
}

// Main View Routable
//extension HomeTabBarController {
//    
//    static let feedRoute = FeedViewController.identifier
//    static let friendRoute = FriendsViewController.identifier
//    static let createRoute = CreateViewController.identifier
//    static let meRoute = MeViewController.identifier
//    
//    func pushRouteSegment(routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: RoutingCompletionHandler) -> Routable {
//        
//        print(routeElementIdentifier)
//        
//        switch routeElementIdentifier {
////        case feedRoute:
////            
////        case friendRoute:
////        case createRoute:
////        case meRoute:
//        case signupRoute:
//            let signupVC = StoryboardScene.Login.OnboardingScene.viewController() as! OnboardingViewController
//            signupVC.type = .SignUp
////            self.viewController.presentViewController(signupVC, animated: false, completion: completionHandler)
//        case loginRoute:
//            let loginVC = StoryboardScene.Login.OnboardingScene.viewController() as! OnboardingViewController
//            loginVC.type = .LogIn
////            self.viewController.presentViewController(loginVC, animated: false, completion: completionHandler)
//        default:
//            assertionFailure()
//        }
//        
//        return OnboardingRoutable()
//    }
//    
//}
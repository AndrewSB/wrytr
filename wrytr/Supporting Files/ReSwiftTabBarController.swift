//
//  ReSwiftTabBarController.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/1/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

import ReSwift
import ReSwiftRouter

protocol Identifiable {
    static var identifier: String { get }
}

class ReSwiftTabBarController: UITabBarController {
    
    static let identifier = "HomeTabBarController" // this makes the class un-reusable
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
}


extension ReSwiftTabBarController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        var vc = viewController
        if let navCon = viewController as? UINavigationController {
            vc = navCon.viewControllers[0]
        }
        
         let destinationVC = self.viewControllers?
            .map {
                if let navCon = $0 as? UINavigationController {
                    return navCon.viewControllers[0]
                } else {
                    return $0
                }
            }
            .filter { (childVC: UIViewController) in
                type(of: vc) == type(of: childVC)
            }
            .first as? Identifiable
        
        if let destinationIdentifier = type(of: destinationVC).identifier {
            store.dispatch(SetRouteAction([ReSwiftTabBarController.identifier, destinationIdentifier]))
        }
        
        return false
    }

}

extension ReSwiftTabBarController: Routable {

    func changeRouteSegment(_ from: RouteElementIdentifier, to: RouteElementIdentifier, animated: Bool, completionHandler: RoutingCompletionHandler) -> Routable {
        
        print("changing \(to)")
                
        let viewController = self.viewControllers?
            .map { $0.unwrapNavigationController() }
            .filter { to == type(of: ($0 as! Identifiable)).identifier }
            .first
        
        
        selectedIndex = self.viewControllers!.indexOf(viewController!.rewrapNavigationController())!
        
        completionHandler()
        return viewController as! Routable
    }
    
    func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: RoutingCompletionHandler) -> Routable {

        let viewController = self.viewControllers?
            .map { $0.unwrapNavigationController() }
            .filter { routeElementIdentifier == type(of: ($0 as! Identifiable)).identifier }
            .first
        
        selectedIndex = self.viewControllers!.indexOf(viewController!.rewrapNavigationController())!
        
        completionHandler()
        return viewController as! Routable
    }

    func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: RoutingCompletionHandler) {
        print("best i ever had")
        completionHandler()
    }
    
}

extension UIViewController {
    
    func unwrapNavigationController() -> UIViewController {
        
        if let navCon = self as? UINavigationController {
            return navCon.viewControllers[0]
        } else {
            return self
        }
        
    }
    
    func rewrapNavigationController() -> UIViewController {
        
        return self.navigationController ?? self
        
    }
    
}

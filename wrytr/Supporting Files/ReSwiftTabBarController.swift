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
    var identifier: String { get }
}

class ReSwiftTabBarController: UITabBarController {
    
    static let identifier = "HomeTabBarController" // this makes the class un-reusable
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    

    
}


extension ReSwiftTabBarController: UITabBarControllerDelegate {

    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        
         let destinationVC = self.viewControllers?
            .filter { (childVC: UIViewController) in
                viewController.dynamicType == childVC.dynamicType
            }
            .first as? Identifiable
        
        if let destinationIdentifier = destinationVC?.identifier {
            store.dispatch(SetRouteAction([ReSwiftTabBarController.identifier, destinationIdentifier]))
        }
        
        return false
    }

}

extension ReSwiftTabBarController: Routable {

    func changeRouteSegment(from: RouteElementIdentifier, to: RouteElementIdentifier, animated: Bool, completionHandler: RoutingCompletionHandler) -> Routable {
        
        return self.viewControllers?
            .filter { to == ($0 as! Identifiable).identifier }
            .first as! Routable
        
    }

}
//
//  MainViewRoutable.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 3/18/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

import ReSwift
import ReSwiftRouter

class MainViewRoutable: Routable {
    
    let viewController: UIViewController
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
}
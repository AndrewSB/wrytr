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
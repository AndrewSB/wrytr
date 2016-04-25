//
//  CreateViewController.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/14/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

import ReSwiftRouter

class CreateViewController: UIViewController, Identifiable {
    
    static let identifier = "CreateViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create"
        self.tabBarItem = UITabBarItem(title: self.title, image: UIImage(asset: UIImage.Asset.Icon_Tabbar_Feed), tag: 2)
    }

}

extension CreateViewController: Routable {}
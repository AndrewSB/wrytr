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

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.title = "Create"
        self.tabBarItem = UITabBarItem(title: self.title, image: UIImage(asset: .Icon_Tabbar_Create), tag: 2)
        
        self.navigationItem.title = nil
        
    }

}

extension CreateViewController: Routable {}
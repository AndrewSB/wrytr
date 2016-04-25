//
//  MeViewController.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/14/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

import ReSwiftRouter

class MeViewController: UIViewController, Identifiable {
    
    static let identifier = "MeViewController"

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.title = "Me"
        self.tabBarItem = UITabBarItem(title: self.title, image: UIImage(asset: .Icon_Tabbar_Profile), tag: 3)
    }

}

extension MeViewController: Routable {}
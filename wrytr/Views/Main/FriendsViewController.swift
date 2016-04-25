//
//  FriendsViewController.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/14/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

import ReSwiftRouter

class FriendsViewController: UIViewController, Identifiable {
    
    static let identifier = "FriendsViewController"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.title = "Friends"
        self.tabBarItem = UITabBarItem(title: self.title, image: UIImage(asset: .Icon_Tabbar_Friends), tag: 0)
    }

}

extension FriendsViewController: Routable {}
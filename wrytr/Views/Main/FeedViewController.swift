//
//  FeedViewController.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/2/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class FeedViewController: RxViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "Home"
        self.tabBarItem = UITabBarItem(title: self.title, image: UIImage(asset: UIImage.Asset.Icon_Tabbar_Feed), tag: 0)

        Variable(["Keala", "is", "absolutely", "beautiful"]).asObservable()
            .bindTo(tableView.rx_itemsWithCellIdentifier("lol", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel!.text = element
            }
            .addDisposableTo(disposeBag)
    }

}

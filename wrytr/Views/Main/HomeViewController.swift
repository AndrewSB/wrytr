//
//  HomeViewController.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/2/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class HomeViewController: RxViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        Variable(["Yo"]).asObservable()
            .bindTo(tableView.rx_itemsWithCellIdentifier("lol", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel!.text = element
            }
            .addDisposableTo(disposeBag)
    }

}

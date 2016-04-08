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

import ReSwift

class FeedViewController: RxViewController {
    
    @IBOutlet weak var tableView: UITableView!

    let kVar = Variable(["Keala", "is", "absolutely", "beautiful"].map(Post.init))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        self.tabBarItem = UITabBarItem(title: self.title, image: UIImage(asset: UIImage.Asset.Icon_Tabbar_Feed), tag: 0)
        
        kVar.asObservable()
            .bindTo(tableView.rx_itemsWithCellIdentifier("lol", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel!.text = element.prompt
            }
            .addDisposableTo(disposeBag)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        store.dispatch(RequestNewPosts())
    }

}

extension FeedViewController: StoreSubscriber {

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        store.unsubscribe(self)
    }
    
    func newState(state: State) {
        
        kVar.value = state.postState.posts
    }

}
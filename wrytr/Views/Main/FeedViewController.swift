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
import ReSwiftRouter

class FeedViewController: RxViewController, Identifiable {
    
    static let identifier = "FeedViewController"
    
    @IBOutlet weak var tableView: UITableView!

    var kVar: Variable<[Post]>! = Variable([Post]())
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.title = "Home"
        self.tabBarItem = UITabBarItem(title: self.title, image: UIImage(asset: .Icon_Tabbar_Feed), tag: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        kVar.asObservable()
            .bindNext {
                print("new kVar: \($0)")
            }
            .addDisposableTo(disposeBag)
        
        kVar.asObservable()
            .bindTo(tableView.rx_itemsWithCellIdentifier("lol", cellType: UITableViewCell.self)) { (row, element, cell) in
                print("ran")
                return cell.textLabel!.text = element.prompt
            }
            .addDisposableTo(disposeBag)
        
        let posts = ["Keala", "is", "absolutely", "beautiful"].map(Post.init)
        
        kVar.value = posts
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
        
//        kVar.value = state.postState.posts
    }

}

extension FeedViewController: Routable {}
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

import Haneke

import Firebase

class FeedViewController: RxViewController, Identifiable {
    
    static let identifier = "FeedViewController"
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 90
        }
    }

    let posts: Variable<[InflatedPost]>! = Variable([InflatedPost]())
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.title = "Home"
        self.tabBarItem = UITabBarItem(title: self.title, image: UIImage(asset: .Icon_Tabbar_Feed), tag: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        posts.asObservable()
            .bindTo(tableView.rx_itemsWithCellIdentifier("lol", cellType: FeedTableViewCell.self)) { (row, element, cell) in
                cell.prompt.text = element.post.prompt
                cell.profilePicture.setImage(UIImage(asset: .Share).imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
                cell.profilePicture.hnk_setImageFromURL(NSURL(string: element.user.profilePictureUrl)!)
                cell.layoutIfNeeded()
            }
            .addDisposableTo(disposeBag)
    
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        store.dispatch(PostProvider.loadNewPosts)
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
        
        posts.value = state.postState.posts
    }

}

extension FeedViewController: Routable {}
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
    
    let headerTitleView: UIView = {
        let navImageView = UIImageView(image: UIImage(asset: .Wrytr_Worded))
        let navImageHeight = 30
        let navAspectRatio = 446/127
        navImageView.frame.size = CGSize(width: navAspectRatio * navImageHeight, height: navImageHeight)
        
        let titleView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 30)))
        titleView.addSubview(navImageView)
        navImageView.center = titleView.center
        
        return titleView
    }()
    
    @IBOutlet weak var tableView: FeedTableView!
    @IBOutlet weak var postCategory: UISegmentedControl!

    let posts: Variable<[InflatedPost]>! = Variable([InflatedPost]())
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.title = "Home"
        self.tabBarItem = UITabBarItem(title: self.title, image: UIImage(asset: .Icon_Tabbar_Feed), tag: 0)
        
        self.navigationItem.titleView = headerTitleView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        posts.asObservable()
            .bindTo(tableView.data)
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
        
        posts.value = state.postState.new
    }

}

extension FeedViewController: Routable {

    func pushRouteSegment(routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: RoutingCompletionHandler) -> Routable {
        
//        self.showViewController(<#T##vc: UIViewController##UIViewController#>, sender: <#T##AnyObject?#>)
        
        completionHandler()
        
        return self
    }

}
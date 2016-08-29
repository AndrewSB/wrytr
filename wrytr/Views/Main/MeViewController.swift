//
//  MeViewController.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/14/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

import Library

import RxSwift
import RxCocoa

import ReSwift
import ReSwiftRouter

class MeViewController: RxViewController, Identifiable {
    
    static let identifier = "MeViewController"
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var profilePicture: RoundedImageView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var elipses: UIButton!
    
    let posts: Variable<[InflatedPost]>! = Variable([InflatedPost]())

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.title = "Me"
        self.tabBarItem = UITabBarItem(title: self.title, image: UIImage(asset: .Icon_Tabbar_Profile), tag: 3)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        posts.asObservable()
            .bindTo(tableView.rx_itemsWithCellIdentifier("lol")) { (row, element, cell) in
                cell.textLabel?.text = element.post.prompt
            }
            .addDisposableTo(disposeBag)
        
        _ = User.local.profilePictureNSUrl.flatMap { profilePicture.hnk_setImageFromURL($0) }
        
        name.text = User.local.authData.name
        
        elipses.rx_tap
            .subscribeNext {
                store.dispatch(SetRouteAction([mainRoute, MeViewController.identifier, "Settings"]))
            }
            .addDisposableTo(disposeBag)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        store.dispatch(PostProvider.loadMyPosts)
    }

}

extension MeViewController: StoreSubscriber {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        store.unsubscribe(self)
    }
    
    func newState(state: State) {
        print(state.postState)
        
        posts.value = state.postState.mine
    }
    
}

extension MeViewController: Routable {

    func pushRouteSegment(routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: RoutingCompletionHandler) -> Routable {
        
        if routeElementIdentifier == "Settings" {
            
            let actions: [(String, UIAlertActionStyle, ((UIAlertAction) -> Void)?)] = [
                ("Sign Out", .Destructive, { _ in store.dispatch(AuthenticationProvider.logout) }),
                ("Edit Bio", .Default, nil),
                ("Change Username", .Default, nil),
                ("Cancel", .Cancel, { _ in
                    store.dispatch(SetRouteAction([mainRoute, MeViewController.identifier]))
                })
            ]
            
            let settingsAlert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            actions
                .map(UIAlertAction.init)
                .forEach(settingsAlert.addAction)
            
            self.presentViewController(settingsAlert, animated: true, completion: nil)
            
        }

        completionHandler()
        return self.tabBarController as! HomeTabBarController
    }

    func popRouteSegment(routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: RoutingCompletionHandler) {
        
        if routeElementIdentifier == "Settings" {
            print("did pop settings")
        }
        
        completionHandler()
    }
}
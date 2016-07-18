//
//  CreateViewController.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/14/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

import RxSwift

import ReSwift
import ReSwiftRouter

import Haneke

class CreateViewController: RxViewController, Identifiable {
    
    static let identifier = "CreateViewController"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.title = "Create"
        self.tabBarItem = UITabBarItem(title: self.title, image: UIImage(asset: .Icon_Tabbar_Create), tag: 2)
        
        self.navigationItem.title = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dismissKeyboardTap = UITapGestureRecognizer()
        dismissKeyboardTap.rx_event.subscribeNext { _ in self.view.endEditing(true) }.addDisposableTo(disposeBag)
        view.addGestureRecognizer(dismissKeyboardTap)
    }

}

extension CreateViewController: StoreSubscriber {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        store.unsubscribe(self)
    }
    
    func newState(state: State) {
    
        if let result = state.createPostState.didUpload {
            switch result {
            case .Success(let post):
                print("post created \(post)")
            case .Failure(let error):
                print("error \(error)")
            }
        }
        
        if let _ = state.createPostState.toBeUploaded { stopLoading() }

    }
    
}

extension CreateViewController: Routable {}
//
//  FeedProvider.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 7/19/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

import ReSwift
import ReSwiftRouter

class FeedProvider {
    
    static func selectPost(post: InflatedPost) -> (state: StateType, store: Store<State>) -> Action? {
        
        return { state, store in
            store.dispatch(SelectPostAction(post: post))
            store.dispatch(SetRouteAction([ReSwiftTabBarController.identifier, FeedViewController.identifier, PostDetailViewController.identifier]))
            store.dispatch(SelectPostAction(post: nil))
            
            return nil
        }
        
    }
    
}
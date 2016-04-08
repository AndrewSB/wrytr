//
//  PostProvider.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/7/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

import ReSwift

import Firebase

class PostProvider {

    static func loadNewPosts(state: StateType, store: Store<State>) -> Action? {
        
        let postsRef = firebase.childByAppendingPath("posts")
        postsRef.queryOrderedByChild("ts")//.observeEventType(FEvent, withBlock: <#T##((FDataSnapshot!) -> Void)!##((FDataSnapshot!) -> Void)!##(FDataSnapshot!) -> Void#>)
        
        return nil
    }

}
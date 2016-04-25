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
        
        firebase.childByAppendingPath("posts").queryOrderedByChild("date")
            .observeEventType(.Value) { (snapshot, _) in
                let snapshotKeys = snapshot.value as? Dictionary<String, Dictionary<String, String>>
                
                let posts: [Post] = snapshotKeys?.values.map { postDict -> Post in
                    Post(user: postDict["user"]!, prompt: postDict["prompt"]!, stars: nil, comments: nil)
                } ?? [Post]()

                store.dispatch(UpdatePosts(posts: posts))
            }
        
        return nil
    }

}
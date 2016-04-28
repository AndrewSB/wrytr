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
    
    static let neverDispose = DisposeBag()

    static func loadNewPosts(state: StateType, store: Store<State>) -> Action? {
        
        firebase.childByAppendingPath("posts" as String!).queryOrderedByChild("date" as String!)
            .rx_observeEventOnce(.Value)
            .map { snapshot -> [Post] in
                let snapshotKeys = snapshot.value as? Dictionary<String, Dictionary<String, String>>
                let posts: [Post] = snapshotKeys?.values.map { postDict -> Post in
                    Post(userId: postDict["user"]!, prompt: postDict["prompt"]!, stars: nil, comments: nil)
                    } ?? [Post]()
            
                return posts
            }
            .flatMap { posts in
                posts.map { $0.inflate() }
                    .toObservable()
                    .merge()
                    .toArray()
            }
            .subscribeNext { store.dispatch(UpdatePosts(posts: $0)) }
            .addDisposableTo(neverDispose)
        
        return nil
    }

}
//
//  Post.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/7/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

import RxSwift

import Firebase

struct Post {
    let id: String

    let userId: String
    let prompt: String

    let stars: [Response]?
    let comments: [Response]?
    
}

extension Post {
    
    func inflate() -> Observable<InflatedPost> {
        
        return firebase.childByAppendingPath("users/\(userId)").rx_observeEventOnce(.Value)
            .map { $0.value as! Dictionary<String, String> }
            .map(User.AuthData.init)
            .map { ($0, nil) }
            .map(User.init)
            .map { user in
                InflatedPost(post: self, user: user)
            }
    }
    
    static func inflate(posts: [Post]) -> Observable<[InflatedPost]> {
        return posts.map { $0.inflate() }
            .toObservable()
            .merge()
            .toArray()
    }
    
}

extension Post {
    
    static func parseFromFirebase(snapshot: FDataSnapshot) -> [Post] {
        let snapshotKeys = snapshot.value as? Dictionary<String, Dictionary<String, String>>
        
        let posts: [Post] = snapshotKeys?.map { postDict -> Post in
            Post(
                id: postDict.0,
                userId: postDict.1["user"]!,
                prompt: postDict.1["prompt"]!,
                stars: nil,
                comments: nil
            )
            } ?? [Post]()
        
        return posts
    }
    
}

extension Post {

    func asAnyObject() -> AnyObject {
        
        return [
            "userId": userId,
            "prompt": prompt
        ]
        
    }

}

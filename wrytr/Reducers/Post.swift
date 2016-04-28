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

    let userId: String
    let prompt: String

    let stars: [Response]?
    let comments: [Response]?
    
}

extension Post {
    
    func inflate() -> Observable<InflatedPost> {
        
        return firebase.childByAppendingPath("users/\(userId)").rx_observeEventOnce(.Value)
            .map { $0.value as! Dictionary<String, String> }
            .map(User.init)
            .map { user in
                InflatedPost(post: self, user: user)
            }
        
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

let dummyPost = Post(userId: "facebook:10207161782556434", prompt: "yo yo", stars: nil, comments: nil)
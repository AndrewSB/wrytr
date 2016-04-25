//
//  Post.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/7/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

public struct Post {

    let user: String
    let prompt: String

    let stars: [Response]?
    let comments: [Response]?
    
}

public extension Post {

    func asAnyObject() -> AnyObject {
        
        return [
            "user": user,
            "prompt": prompt
        ]
        
    }

}

let dummyPost = Post(user: "facebook:10207161782556434", prompt: "yo yo", stars: nil, comments: nil)
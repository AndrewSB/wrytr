//
//  Comment.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/25/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

struct Response {
    
    let user: String
    let content: String
    let post: String
    
    var isStar: Bool { return content == "🌟" }
    
}

let dummyComment = Response(user: "facebook:10207161782556434", content: "sucks", post: "no post")
let dummyStar = Response(user: "facebook:10207161782556434", content: "🌟", post: "no post")

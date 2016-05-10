//
//  CreatePostsActions.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 5/9/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

import ReSwift

struct LocalPostReady: Action {
    let post: Post
}

struct PostCreationCompleted: Action {
    let post: Post?
    let error: NSError?
}
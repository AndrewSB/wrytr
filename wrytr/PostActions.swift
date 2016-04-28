//
//  PostActions.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/7/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

import ReSwift

struct RequestNewPosts: Action {}

struct UpdatePosts: Action {
    let posts: [InflatedPost]
}
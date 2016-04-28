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

struct RequestMyPosts: Action {}

struct UpdatePosts: Action {
    let newPosts: [InflatedPost]?
    let myPosts: [InflatedPost]?
}
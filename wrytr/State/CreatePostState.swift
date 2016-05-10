//
//  CreatePostState.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 5/9/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

import Result

import ReSwift

struct CreatePostState {
    var toBeUploaded: Post?
    var didUpload: Result<Post, NSError>?
}
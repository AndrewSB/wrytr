//
//  CreatePostReducer.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 5/10/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

import Result

import ReSwift

func createPostReducer(_ action: Action, state: CreatePostState?) -> CreatePostState {
    var state = state ?? initialCreatePostState()

    switch action {
    case let action as LocalPostReady:
        state.toBeUploaded = action.post
    case let action as PostCreationCompleted:
        state.didUpload = Result<Post, NSError>(action.post, failWith: action.error ?? NSError(localizedDescription: "Post creation failed", code: -1))
        state.toBeUploaded = nil
    default:
        break
    }

    return state
}

private func initialCreatePostState() -> CreatePostState {
    return CreatePostState(toBeUploaded: nil, didUpload: nil)
}

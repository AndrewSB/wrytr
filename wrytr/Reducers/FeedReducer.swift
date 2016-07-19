//
//  FeedReducer.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 7/19/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

import ReSwift

func feedReducer(action: Action, state: FeedState?) -> FeedState {
    var state = state ?? initialFeedState()
    
    switch action {
    case let action as SelectPostAction:
        state.selectedPost = action.post
    default:
        break
    }
    
    return state
}

private func initialFeedState() -> FeedState {
    return FeedState(selectedPost: nil)
}
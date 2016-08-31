import Foundation

import ReSwift

func feedReducer(_ action: Action, state: FeedState?) -> FeedState {
    var state = state ?? initialFeedState()
    
    switch action {
    case let action as SelectPostAction:
        state.selectedPost = action.post
        state.displayState = action.displayState
    default:
        break
    }
    
    return state
}

private func initialFeedState() -> FeedState {
    return FeedState(selectedPost: nil, displayState: nil)
}

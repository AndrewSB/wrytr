import Foundation

import ReSwift

func postReducer(_ action: Action, state: PostState?) -> PostState {
    var state = state ?? initialPostState()
    
    switch action {
    case is RequestNewPosts:
        state.busyLoading = true
    case is RequestMyPosts:
        state.busyLoading = true
    case let action as UpdatePosts:
        if let newPosts = action.newPosts { state.new = newPosts }
        if let myPosts = action.myPosts { state.mine = myPosts }
        state.busyLoading = false
    default:
        break
    }
    
    return state
}

private func initialPostState() -> PostState {
    
    return PostState(
        busyLoading: false,
        new: [InflatedPost](),
        mine: [InflatedPost]()
    )

}

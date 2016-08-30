import Foundation

import ReSwift
import ReSwiftRouter

struct State: StateType {
    var navigationState: NavigationState
    var authenticationState: AuthenticationState
    var postState: PostState
    var feedState: FeedState
    var createPostState: CreatePostState
}

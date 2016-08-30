import Foundation

import ReSwift
import ReSwiftRouter

struct AppReducer: Reducer {
    
    func handleAction(_ action: Action, state: State?) -> State {
        return State(
            navigationState: NavigationReducer.handleAction(action, state: state?.navigationState),
            authenticationState: authenticationReducer(action, state: state?.authenticationState),
            postState: postReducer(action, state: state?.postState),
            feedState: feedReducer(action, state: state?.feedState),
            createPostState: createPostReducer(action, state: state?.createPostState)
        )
    }
    
}

import Foundation

import ReSwift
import ReSwiftRouter

class FeedProvider {
    
    static func selectPost(_ post: InflatedPost) -> (_ state: StateType, _ store: Store<State>) -> Action? {
        
        return { state, store in
            store.dispatch(SetRouteAction([ReSwiftTabBarController.identifier, FeedViewController.identifier, PostDetailViewController.identifier]))
            store.dispatch(SelectPostAction(post: post, displayState: .list))
            
            return nil
        }
        
    }
    
}

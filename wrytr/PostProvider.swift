import Foundation

import RxSwift
import RxCocoa

import ReSwift

import Firebase

class PostProvider {
    
    static let neverDispose = DisposeBag()

    static func loadNewPosts(_ state: StateType, store: Store<State>) -> Action? {
        
        firebase.childByAppendingPath("posts" as String!).queryOrderedByChild("date" as String!)
            .rx_observeEventOnce(.Value)
            .map(Post.parseFromFirebase)
            .flatMap(Post.inflate)
            .subscribeNext { store.dispatch(UpdatePosts(newPosts: $0, myPosts: nil)) }
            .addDisposableTo(neverDispose)
        
        return nil
    }
    
    // currently is exactly the same as loadNewPosts. Need to implement following
    static func loadFriendPosts(_ state: StateType, store: Store<State>) -> Action? {
        
        firebase.childByAppendingPath("posts" as String!).queryOrderedByChild("date" as String!)
            .rx_observeEventOnce(.Value)
            .map(Post.parseFromFirebase)
            .flatMap(Post.inflate)
            .subscribeNext { store.dispatch(UpdatePosts(newPosts: $0, myPosts: nil)) }
            .addDisposableTo(neverDispose)
        
        return nil
    }
    
    static func loadMyPosts(_ state: StateType, store: Store<State>) -> Action? {
        
        firebase.childByAppendingPath("posts")
            .queryOrderedByChild("user")
            .queryEqualToValue(firebase.authData.uid)
            .rx_observeEventOnce(.Value)
            .map(Post.parseFromFirebase)
            .flatMap(Post.inflate)
            .subscribeNext { store.dispatch(UpdatePosts(newPosts: nil, myPosts: $0)) }
            .addDisposableTo(neverDispose)
        
        return nil
    }

}

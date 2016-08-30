import Foundation

import RxSwift
import RxCocoa

import ReSwift

import Firebase

class CreatePostProvider {
    static let neverDisposeBag = DisposeBag()
    
    static func uploadPost(_ state: StateType, store: Store<State>) -> Action? {
        
        if let post = store.state.createPostState.toBeUploaded {
            firebase?.child(byAppendingPath: "posts")
                .rx_setChildByAutoId(post.asAnyObject())
                .subscribe { observer in
                    switch observer {
                    case .Error(let err):
                        store.dispatch(PostCreationCompleted(post: nil, error: err as NSError))
                    case .Next:
                        store.dispatch(PostCreationCompleted(post: post, error: nil))
                    case .Completed:
                        break
                    }
                }
                .addDisposableTo(neverDisposeBag)
        }
        
        return nil
    }
    
}

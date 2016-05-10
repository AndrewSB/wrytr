//
//  CreatePostProvider.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 5/9/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

import ReSwift

import Firebase

class CreatePostProvider {
    static let neverDisposeBag = DisposeBag()
    
    static func uploadPost(state: StateType, store: Store<State>) -> Action? {
        
        if let post = store.state.createPostState.toBeUploaded {
            firebase.childByAppendingPath("posts")
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
//
//  AppReducer.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 3/18/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

import ReSwift
import ReSwiftRouter

struct AppReducer: Reducer {
    
    func handleAction(action: Action, state: State?) -> State {
        return State(
            navigationState: NavigationReducer.handleAction(action, state: state?.navigationState),
            authenticationState: authenticationReducer(action, state: state?.authenticationState),
            postState: postReducer(action, state: state?.postState),
            feedState: feedReducer(action, state: state?.feedState),
            createPostState: createPostReducer(action, state: state?.createPostState)
        )
    }
    
}
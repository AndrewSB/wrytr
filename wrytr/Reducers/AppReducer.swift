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
            authenticationState: authenticationReducer(state?.authenticationState, action: action)
        )
    }
    
}
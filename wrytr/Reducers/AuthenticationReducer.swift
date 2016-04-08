//
//  AuthenticationReducer.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 3/18/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

import ReSwift
import ReSwiftRouter

import Firebase

func authenticationReducer(action: Action, state: AuthenticationState?) -> AuthenticationState {
    var state = state ?? initialAuthenticationState()
    
    switch action {
    case let action as UpdateLoggedInState:
        state.loggedInState = action.loggedInState
    default:
        break
    }
    
    return state
}

func initialAuthenticationState() -> AuthenticationState {
    
    if let authData = firebase?.authData {
        return AuthenticationState(loggedInState: .LoggedIn(Social(authData: authData)!))
    } else {
        return AuthenticationState(loggedInState: .NotLoggedIn)
    }
    
}

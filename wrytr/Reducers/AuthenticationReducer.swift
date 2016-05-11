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
    case let action as NewLandingState:
        state.landingState = action.state
    default:
        break
    }
    
    return state
}

private func initialAuthenticationState() -> AuthenticationState {
    
    let loggedInState: LoggedInState = firebase.authData != nil
        ? .LoggedIn(Social(authData: firebase.authData)!)
        : .NotLoggedIn
    
    return AuthenticationState(landingState: .Login, loggedInState: loggedInState)
    
}

import Foundation

import ReSwift
import ReSwiftRouter

import Firebase

func authenticationReducer(_ action: Action, state: AuthenticationState?) -> AuthenticationState {
    var state = state ?? initialAuthenticationState()
    
    switch action {
    case let action as UpdateLoggedInState:
        switch action.loggedInState {
        case .logout:
            state.loggedInState = .notLoggedIn
        case .errorLoggingIn, .loggedIn, .notLoggedIn:
            state.loggedInState = action.loggedInState
        }
    case let action as NewLandingState:
        state.landingState = action.state
    default:
        break
    }
    
    return state
}

private func initialAuthenticationState() -> AuthenticationState {
    
    let loggedInState: LoggedInState = firebase.authData != nil
        ? .loggedIn(Social(authData: firebase.authData)!)
        : .notLoggedIn
    
    return AuthenticationState(landingState: .Login, loggedInState: loggedInState)
    
}

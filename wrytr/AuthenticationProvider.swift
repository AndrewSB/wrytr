//
//  AuthenticationProvider.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/1/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

import Library

import RxSwift

import ReSwift
import ReSwiftRouter

import FBSDKLoginKit
import TwitterKit

// This is an example of an Action Creator Provider
class AuthenticationProvider {

    class func loginWithFacebook(state: StateType, store: Store<State>) -> Action? {
        
        FBSDKLoginManager().rx_login()
            .flatMap { loginResult -> Observable<LoggedInState> in
                
                if loginResult.isCancelled {
                    return Observable.error(NSError(localizedDescription: "Did you cancel the login?", code: 99))
                } else {
                    return firebase.rx_oauth("facebook", token: FBSDKAccessToken.currentAccessToken().tokenString).map { LoggedInState.LoggedIn(Social.Facebook($0)) }
                }
                
            }
            .subscribe(handleAuthenticationResponse)
            .addDisposableTo(neverDisposeBag)
        
        return nil
    }
    
    class func loginWithTwitter(state: StateType, store: Store<State>) -> Action? {
        
        Twitter.sharedInstance().rx_login()
            .map { ("twitter", parameters: ["user_id": $0.userID, "oauth_token": $0.authToken, "oauth_token_secret": $0.authTokenSecret]) }
            .flatMap(firebase.rx_oauth)
            .map(Social.Twitter)
            .map(LoggedInState.LoggedIn)
            .subscribe(handleAuthenticationResponse)
            .addDisposableTo(neverDisposeBag)
        
        return nil
    }
    
    private class func handleAuthenticationResponse(observer: Event<LoggedInState>) {
        
        switch observer {
        case .Error(let error):
            store.dispatch(UpdateLoggedInState(loggedInState: LoggedInState.ErrorLoggingIn(error as NSError)))
        case .Next(let loggedInState):
            store.dispatch(UpdateLoggedInState(loggedInState: loggedInState))
            store.dispatch(SetRouteAction([mainRoute]))
        case .Completed:
            break
        }
        
    }
    
}

extension AuthenticationProvider {}
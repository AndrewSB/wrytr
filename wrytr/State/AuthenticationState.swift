//
//  AuthenticationState.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 3/18/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

import Firebase

import ReSwift
import ReSwiftRouter

import Twitter
import TwitterKit

struct AuthenticationState {
    var loggedInState: LoggedInState
}

enum LoggedInState {
    case NotLoggedIn
    case ErrorLoggingIn(NSError)
    case LoggedIn(Social)
}

enum Social {
    case Facebook(FAuthData)
    case Twitter(FAuthData)
}

extension Social {

    init?(authData: FAuthData) {
        switch authData.provider {
        case "facebook":
            self = Facebook(authData)
        case "twitter":
            self = Twitter(authData)
        default:
            return nil
        }
    }

}
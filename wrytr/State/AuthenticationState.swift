//
//  AuthenticationState.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 3/18/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

import ReSwift
import ReSwiftRouter

import Twitter
import TwitterKit

struct AuthenticationState {
    var loggedInState: LoggedInState
}

enum LoggedInState {
    case NotLoggedIn
    case LoggedIn(Social)
}

enum Social {
    case Facebook
    case Twitter(TWTRSession)
}
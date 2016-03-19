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

struct AuthenticationState {
    var loggedInState: LoggedInState
}

enum LoggedInState {
    case NotLoggedIn
    case LoggedIn
}
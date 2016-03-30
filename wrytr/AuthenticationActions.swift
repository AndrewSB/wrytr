//
//  AuthenticationActions.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 3/21/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

import ReSwift

struct UpdateLoggedInState: Action {
    let loggedInState: LoggedInState
}
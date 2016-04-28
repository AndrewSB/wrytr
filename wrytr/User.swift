//
//  User.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/26/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

struct User {
    let name: String
    let id: String
    let profilePictureUrl: String
}

extension User {
    init(dict: Dictionary<String, String>) {
        self.name = dict["name"]!
        self.id = dict["id"]!
        self.profilePictureUrl = dict["profilePictureUrl"]!
    }
}
//
//  User.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/26/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

import Firebase

struct User {
    let name: String
    let id: String
    let profilePictureUrl: String
}

extension User {
    init(dict: [String: String]) {
        self.name = dict["name"]!
        self.id = dict["id"]!
        self.profilePictureUrl = dict["profilePictureUrl"]!
    }
}

extension User {
    
    static var local: User {
        return User(dict: User.scrapeAuthData(firebase.authData))
    }
    
    var profilePictureNSUrl: NSURL {
        return NSURL(string: profilePictureUrl)!
    }
    
}

extension User {
    
    static func scrapeAuthData(authData: FAuthData) -> [String: String] {
        
        let userDict = [
            "name": authData.name,
            "id": authData.id,
            "profilePictureUrl": "\(authData.profilePictureUrl)",
        ]
        
        return userDict
        
    }
    
}
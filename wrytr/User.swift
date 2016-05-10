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
    let authData: User.AuthData
    
    let following: [String]?
}

extension User {
    
    struct AuthData {
        let name: String
        let id: String
        let profilePictureUrl: String
        
        init(dict: [String: String]) {
            self.name = dict["name"]!
            self.id = dict["uid"]!
            self.profilePictureUrl = dict["profilePictureUrl"]!
        }
        
        init(authData: FAuthData) {
            self.init(dict: AuthData.scrapeAuthData(authData))
        }
        
        static func scrapeAuthData(authData: FAuthData) -> [String: String] {
            return [
                "name": authData.name,
                "uid": authData.uid,
                "profilePictureUrl": "\(authData.profilePictureUrl)",
            ]
        }

    }

}

extension User {

    var profilePictureNSUrl: NSURL {
        return NSURL(string: authData.profilePictureUrl)!
    }

}

extension User {
    
    static var local: User {
        return User(authData: User.AuthData(authData: firebase.authData), following: nil)
    }
    
}
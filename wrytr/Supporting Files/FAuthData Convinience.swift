//
//  FAuthData Convinience.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/26/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

import Firebase

extension FAuthData {
    
    var profilePictureUrl: NSURL {
        var urlString = self.providerData!["profileImageURL" as NSObject] as! String
        
        if let normalRange = urlString.rangeOfString("_normal") {
            urlString.removeRange(normalRange) // twitter
        }
        
        
        return NSURL(string: urlString)!
    }
    
    var id: String {
        return self.providerData!["id" as NSObject] as! String
    }
    
    var name: String {
        return self.providerData!["displayName" as NSObject] as! String
    }
    
}
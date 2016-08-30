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
    
    var profilePictureUrl: URL? {
        var urlString = self.providerData!["profileImageURL" as NSObject] as? String
        
        if let normalRange = urlString?.range(of: "_normal") {
            urlString!.removeSubrange(normalRange) // twitter
        }
        
        return urlString.flatMap(URL.init)
    }
    
    var name: String? {
        return
            self.providerData!["displayName" as NSObject] as? String
    }
    
}

//
//  NSRangeExtension.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 5/10/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import Foundation

extension NSRange {
    
    init(ofString: String, inString: String) {
        self = NSString(string: inString).rangeOfString(ofString)
    }
    
    static func rangeGenerator(withString inString: String) -> ((String) -> NSRange) {
        
        return { (ofString: String) -> NSRange in
            return NSRange(ofString: ofString, inString: inString)
        }
    }
    
}
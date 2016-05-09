//
//  NoHairlineNavigationBar.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 5/9/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

class NoHairlineNavigationBar: UINavigationBar {
    
    var backgroundTint: UIColor = .clearColor()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // The navigation bar's shadowImage is set to a transparent image. In conjunction with providing a custom background image, this removes the grey hairline at the bottom of the navigation bar. The will draw its own hairline.
        shadowImage = UIImage.imageWithColor(.clearColor())
        setBackgroundImage(UIImage.imageWithColor(backgroundTint), forBarMetrics: .Default)
    }

}

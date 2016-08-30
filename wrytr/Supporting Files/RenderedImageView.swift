//
//  RenderedImageView.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/25/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

class RenderedImageView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
    }

}


class RenderedImageButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let image = self.imageView?.image {
            setImage(image.withRenderingMode(.alwaysTemplate), for: UIControlState())
        }
    }
    
}

//
//  FeedTableViewCell.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/25/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

import Library

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var elipses: UIButton!
    @IBOutlet weak var profilePicture: UIButton!
    @IBOutlet weak var prompt: UILabel!
    
    
    @IBOutlet weak var stars: RenderedImageButton!
    @IBOutlet weak var comments: RenderedImageButton!
    @IBOutlet weak var share: RenderedImageButton!
    @IBOutlet weak var reply: RoundedButton! {
        didSet {
            reply.layer.borderColor = UIColor.lightGrayColor().CGColor
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let elipsesImage = UIImage(asset: .Elipses).imageWithRenderingMode(.AlwaysTemplate)
        elipses.setImage(elipsesImage, forState: .Normal)
    }

}

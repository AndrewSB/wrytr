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

    @IBOutlet weak var elipses: UIButton! {
        didSet {
            let elipsesImage = UIImage(asset: .Elipses).imageWithRenderingMode(.AlwaysTemplate)
            elipses.setImage(elipsesImage, forState: .Normal)
        }
    }
    @IBOutlet weak var profilePicture: RoundedButton! {
        didSet {
            profilePicture.clipsToBounds = true
            profilePicture.imageView!.contentMode = .ScaleAspectFit
            self.setNeedsLayout()
        }
    }
    @IBOutlet weak var prompt: UILabel!
    
    
    @IBOutlet weak var stars: RenderedImageButton!
    @IBOutlet weak var comments: RenderedImageButton!
    @IBOutlet weak var share: RenderedImageButton!
    @IBOutlet weak var reply: RoundedButton! {
        didSet {
            reply.layer.borderColor = UIColor.lightGrayColor().CGColor
        }
    }
}

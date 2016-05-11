//
//  ChallengeTableViewCell.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 4/25/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

import Library

class ChallengeTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var elipses: UIButton! {
        didSet {
            let elipsesImage = UIImage(asset: .Elipses).imageWithRenderingMode(.AlwaysTemplate)
            elipses.setImage(elipsesImage, forState: .Normal)
        }
    }
    @IBOutlet weak var profilePicture: RoundedImageView! {
        didSet {
            profilePicture.clipsToBounds = true
            profilePicture.contentMode = .ScaleAspectFit
        }
    }
    @IBOutlet weak var prompt: UILabel!
    
    
    @IBOutlet weak var stars: RenderedImageButton! {
        didSet { stars.imageView!.contentMode = .ScaleAspectFit }
    }
    @IBOutlet weak var comments: RenderedImageButton! {
        didSet { comments.imageView!.contentMode = .ScaleAspectFit }
    }
    @IBOutlet weak var share: RenderedImageButton! {
        didSet { share.imageView!.contentMode = .ScaleAspectFit }
    }
    @IBOutlet weak var reply: RoundedButton! {
        didSet {
            reply.layer.borderWidth = 1
            reply.layer.borderColor = UIColor.lightGrayColor().CGColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor.lightGrayColor().CGColor
        layer.borderWidth = 1

        layer.cornerRadius = 10
    }
}

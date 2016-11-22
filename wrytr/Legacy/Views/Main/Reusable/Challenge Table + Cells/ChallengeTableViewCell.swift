import UIKit

import Library

class ChallengeTableViewCell: UITableViewCell {

    var xInsets: CGFloat?

    @IBOutlet weak var elipses: UIButton! {
        didSet {
            let elipsesImage = UIImage(asset: .elipses).withRenderingMode(.alwaysTemplate)
            elipses.setImage(elipsesImage, for: UIControlState())
        }
    }
    @IBOutlet weak var profilePicture: RoundedImageView! {
        didSet {
            profilePicture.clipsToBounds = true
            profilePicture.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var prompt: UILabel!

    @IBOutlet weak var stars: RenderedImageButton! {
        didSet { stars.imageView!.contentMode = .scaleAspectFit }
    }
    @IBOutlet weak var comments: RenderedImageButton! {
        didSet { comments.imageView!.contentMode = .scaleAspectFit }
    }
    @IBOutlet weak var share: RenderedImageButton! {
        didSet { share.imageView!.contentMode = .scaleAspectFit }
    }
    @IBOutlet weak var reply: RoundedButton! {
        didSet {
            reply.layer.borderWidth = 1
            reply.layer.borderColor = UIColor.lightGray.cgColor
        }
    }

    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame

            frame.origin.x += xInsets ?? 0
            frame.size.width = newFrame.width - (2 * (xInsets ?? 0))

            super.frame = frame
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1

        layer.cornerRadius = 10
    }

}

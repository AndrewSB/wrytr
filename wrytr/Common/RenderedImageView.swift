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

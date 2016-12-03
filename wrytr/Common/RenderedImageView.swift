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

        setImage(self.imageView!.image.withRenderingMode(.alwaysTemplate), for: UIControlState())
    }

}

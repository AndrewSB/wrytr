import UIKit
import Library

class RoundedRenderedImageButton: RenderedImageButton, Roundable {

    override public func awakeFromNib() {
        super.awakeFromNib()

        round()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        round()
    }

}

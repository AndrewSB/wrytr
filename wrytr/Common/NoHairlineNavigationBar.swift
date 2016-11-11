import UIKit
import Library

class NoHairlineNavigationBar: UINavigationBar {

    override func awakeFromNib() {
        super.awakeFromNib()

        // swiftlint:disable:next line_length
        // The navigation bar's shadowImage is set to a transparent image. In conjunction with providing a custom background image, this removes the grey hairline at the bottom of the navigation bar. The will draw its own hairline.
        shadowImage = UIImage.image(withColor: .clear)
        setBackgroundImage(UIImage.image(withColor: barTintColor!), for: .default)
    }

}

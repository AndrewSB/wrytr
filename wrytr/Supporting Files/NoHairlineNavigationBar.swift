import UIKit

class NoHairlineNavigationBar: UINavigationBar {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // The navigation bar's shadowImage is set to a transparent image. In conjunction with providing a custom background image, this removes the grey hairline at the bottom of the navigation bar. The will draw its own hairline.
        shadowImage = UIImage.imageWithColor(color: .clear)
        setBackgroundImage(UIImage.imageWithColor(color: barTintColor!), for: .default)
    }

}

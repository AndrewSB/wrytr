import UIKit

class ExtendedNavigationBarView: UIView {

    //| ------------------------------------------------------------------------
    //  Called when the view is about to be displayed.  May be called more than
    //  once.
    //
    override func willMove(toWindow newWindow: UIWindow?) {
        // Use the layer shadow to draw a one pixel hairline under this view.
        layer.shadowOffset = CGSize(width: 0, height: 1 / UIScreen.main.scale)
        layer.shadowRadius = 0

        // UINavigationBar's hairline is adaptive, its properties change with
        // the contents it overlies.  You may need to experiment with these
        // values to best match your content.
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
    }

}

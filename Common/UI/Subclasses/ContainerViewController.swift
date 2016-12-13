import UIKit

class ContainerViewController<Contained: UIViewController>: UIViewController {
    let contained: Contained

    init(viewController: Contained) {
        self.contained = viewController
        super.init(nibName: nil, bundle: nil) // bad practice, plz refactor when crashes

        self.automaticallyAdjustsScrollViewInsets = false // so we don't get top spacing
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewController(contained)
        contained.view.frame = self.view.frame
        self.view.addSubview(contained.view)
        contained.didMove(toParentViewController: self)
    }

}

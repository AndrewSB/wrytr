import UIKit
import Library

extension Create {
    typealias ViewController = CreateViewController
}

extension Create.ViewController {
    static func fromStoryboard() -> CreateViewController {
        return StoryboardScene.Create.instantiateCreate()
    }
}

class CreateNavigationController: UINavigationController {
    static func fromStoryboard() -> CreateNavigationController {
        return StoryboardScene.Create.instantiateCreateNav()
    }
}

class CreateViewController: InterfaceProvidingViewController {

    fileprivate let composeViewController = StoryboardScene.Compose.instantiateCompose()
    @IBOutlet weak var container: UIView!

    struct IB: Primitive {
        let profile: RoundedImageView
        let username: UILabel
        let textView: UITextView
    }

    override func viewDidLoad() {
        self.addChildViewController(composeViewController)
        self.container.addSubview(composeViewController.view)

        let constraints = [
            container.leftAnchor.constraint(equalTo: composeViewController.view.leftAnchor),
            container.rightAnchor.constraint(equalTo: composeViewController.view.rightAnchor),
            container.topAnchor.constraint(equalTo: composeViewController.view.topAnchor),
            container.bottomAnchor.constraint(equalTo: composeViewController.view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)

        self.interface = IB(
            profile: composeViewController.profileImageView,
            username: composeViewController.usernameLabel,
            textView: composeViewController.challengeTextView
        )

        super.viewDidLoad()
    }

}

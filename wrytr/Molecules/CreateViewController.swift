import UIKit
import Library

extension Create {
    typealias ViewController = CreateViewController
    typealias NavigationController = CreateNavigationController
}

class CreateViewController: UIViewController {

    var composeViewController: ComposeViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = tr(.createTitle)

        let localUser = store.state.authenticationState.user!

        composeViewController.username.text = localUser.name
        if let url = localUser.photo {
            composeViewController.profile.pin_setImage(from: url)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let composeVC = segue.destination as? ComposeViewController {
            self.composeViewController = composeVC
        }
    }

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

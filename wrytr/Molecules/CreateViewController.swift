import UIKit
import Library
import Cordux

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

        composeViewController.usernameLabel.text = localUser.name
        if let url = localUser.photo {
            composeViewController.profileImageView.pin_setImage(from: url)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let composeVC = segue.destination as? ComposeViewController {
            self.composeViewController = composeVC
        }
    }

}

extension Create.ViewController: Cordux.SubscriberType {
    typealias StoreSubscriberStateType = App.State

    public func newState(_ subscription: App.State) {

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

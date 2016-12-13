import UIKit
import Library
import Cordux

extension Create {
    typealias ViewController = CreateViewController
    typealias NavigationController = CreateNavigationController
}

class CreateViewController: UIViewController, TabBarItemProviding {

    static let tabItem: UITabBarItem = UITabBarItem().then {
        $0.title = tr(.createTitle)
        $0.image = UIImage(asset: .iconTabbarCreate)
    }

    var composeViewController: ComposeViewController!

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
        guard case let .loggedIn(localUser) = subscription.authenticationState.user else {
            fatalError("You're trying to create something without being logged in")
        }

        composeViewController?.usernameLabel?.text = localUser.name
        if let url = localUser.photo {
            composeViewController?.profileImageView?.pin_setImage(from: url)
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

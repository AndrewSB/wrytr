import UIKit
import Library
import ReSwift
import RxSwift

class Create {
    typealias ViewController = CreateViewController
    typealias NavigationController = CreateNavigationController
}

class CreateViewController: UIViewController, TabBarItemProviding {
    static let tabItem: UITabBarItem = UITabBarItem().then {
        $0.title = tr(.createTitle)
        $0.image = UIImage(asset: .iconTabbarCreate)
    }

    var composeViewController: ComposeViewController!
    var controller: Create.Controller!

    fileprivate let dismissErrorTapped = PublishSubject<Void>()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.controller = Create.Controller(
            input: (
                text: self.composeViewController.challengeTextView.rx.text.unwrap(),
                command: self.composeViewController.postCreated.mapTo(()),
                dismissErrorTapped: dismissErrorTapped.asObservable()
            )
        )
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let composeVC = segue.destination as? ComposeViewController {
            self.composeViewController = composeVC
        }
    }

}

extension Create.ViewController: StoreSubscriber {

    public func newState(state: App.State) {
        guard case let .loggedIn(localUser) = state.authenticationState.user! else {
            fatalError("You're trying to create something without being logged in")
        }

        self.loadViewIfNeeded()

        composeViewController.usernameLabel.text = localUser.name
        if let url = localUser.photo {
            composeViewController.profileImageView.pin_setImage(from: url)
        }

        state.postState.isCreatingPost ? startLoading(.gray) : stopLoading()

        /// @CASE help me
        if let err = state.postState.errorCreating {
            let errorAlert = UIAlertController(title: err.title, message: err.description, preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: tr(.errorDefaultOk), style: .cancel, handler: .none))
            self.present(errorAlert, animated: true, completion: {
                self.dismissErrorTapped.onNext()
            })

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

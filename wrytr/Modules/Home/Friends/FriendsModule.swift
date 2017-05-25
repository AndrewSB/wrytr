import UIKit

class Friends {
    class Module: Routable {
        private let friendsViewController: ViewController

        var rootViewController: UIViewController {
            return friendsViewController
        }

        var route: AppRoute {
            return .home(.friends(.table))
        }

        init(friendsView: Friends.ViewController = ViewController()) {
            self.friendsViewController = friendsView
        }
    }
}

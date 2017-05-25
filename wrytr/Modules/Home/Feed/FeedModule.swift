import UIKit

class Feed {
    class Module: Routable {
        private let feedViewController: ViewController

        var rootViewController: UIViewController {
            return feedViewController
        }

        var route: AppRoute {
            return .home(.feed(.table))
        }

        init(feedView: Feed.ViewController = ViewController()) {
            self.feedViewController = feedView
        }
    }
}

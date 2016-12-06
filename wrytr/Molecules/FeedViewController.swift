import UIKit
import Cordux

extension Feed {
    typealias ViewController = FeedViewController
}

class FeedViewController: UIViewController {
    @IBOutlet weak var newPopularControl: UISegmentedControl!
    @IBOutlet weak var tableView: ChallengeTableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = tr(.feedTitle)
    }
}

extension Feed.ViewController: Cordux.SubscriberType {
    typealias StoreSubscriberStateType = App.State

    func newState(_ state: App.State) {
        print(state)
    }
}

class FeedNavigationController: UINavigationController {
    static func fromStoryboard() -> FeedNavigationController {
        return StoryboardScene.Feed.instantiateFeedNav()
    }
}

extension Feed.ViewController {
    static func fromStoryboard() -> Feed.ViewController {
        let feedVC = StoryboardScene.Feed.instantiateFeed()

        return feedVC
    }
}

import UIKit
import ReSwift

extension Feed {
    typealias ViewController = FeedViewController
}

class FeedViewController: UIViewController, StoreSubscriber {
    @IBOutlet weak var newPopularControl: UISegmentedControl!
    @IBOutlet weak var tableView: ChallengeTableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = tr(.feedTitle)
    }

    func newState(state: Feed.State) {
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

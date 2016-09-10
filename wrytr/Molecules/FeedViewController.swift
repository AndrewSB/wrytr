import UIKit

extension Feed {
    typealias ViewController = FeedViewController
}

extension Feed.ViewController {
    static func fromStoryboard() -> Feed.ViewController {
        let _ = StoryboardScene.Feed.instantiateFeedNav()
        let feedVC = StoryboardScene.Feed.instantiateFeed()

        return feedVC
    }
}

class FeedViewController: InterfaceProvidingViewController {
    @IBOutlet weak var newPopularControl: UISegmentedControl!
    @IBOutlet weak var tableView: ChallengeTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.interface = IB(
            newPopularControl: newPopularControl,
            tableView: tableView
        )
    }

    struct IB: Primitive {
        let newPopularControl: UISegmentedControl
        let tableView: ChallengeTableView
    }
}

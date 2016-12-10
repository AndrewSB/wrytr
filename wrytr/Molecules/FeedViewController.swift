import UIKit
import Cordux
import RxSwift
import RxCocoa
import RxLibrary
import Then

extension Variable: Then {}

extension Feed {
    typealias ViewController = FeedViewController
}

class FeedViewController: RxViewController {
    @IBOutlet weak var tableView: ChallengeTableView! {
        didSet {
            tableView.segmentedControlSectionTitles = ["New", "Popular"]
        }
    }

    var controller: Feed.Controller!

    lazy var posts: Variable<[PostType]> = Variable([]).then {
        $0.asDriver().drive(self.tableView.posts).addDisposableTo(self.disposeBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = tr(.feedTitle)

        self.controller = Feed.Controller(
            inputs: (
                pullToRefresh: tableView.refreshControl!.rx.controlEvent(.valueChanged),
                source: .just(.friends),
                ordering: tableView.topSegmentedControl.rx.value.map { value -> Feed.State.Ordering in
                    switch value {
                    case 0: return .new
                    case 1: return .popular
                    default: fatalError("dont know how to handle > 2 cases yet. Just new & popular")
                    }
                }
            ),
            sinks: (
                refreshControlVisible: tableView.refreshControl!.rx.refreshing as UIBindingObserver<UIRefreshControl, Bool>,
                posts: self.posts
            )
        )
    }
}

extension Feed.ViewController: Cordux.SubscriberType {
    typealias StoreSubscriberStateType = App.State

    func newState(_ state: App.State) {
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

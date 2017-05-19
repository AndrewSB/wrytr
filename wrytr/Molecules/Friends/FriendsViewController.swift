import UIKit
import ReSwift
import RxSwift

class Friends {

    class ViewController: ContainerViewController<ChallengeViewController>, TabBarItemProviding {
        static let tabItem: UITabBarItem = UITabBarItem().then {
            $0.title = tr(.friendTitle)
            $0.image = UIImage(asset: .iconTabbarFriends)
        }

        init(challengeViewController: ChallengeViewController) {
            super.init(viewController: challengeViewController)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError()
        }

        var controller: Challenge.Controller!

        override func viewDidLoad() {
            super.viewDidLoad()

            self.contained.tableView.segmentedControlSectionTitles = ["New", "Popular"]

            self.controller = Challenge.Controller(
                inputs: (
                    pullToRefresh: contained.tableView.refreshControl!.rx.controlEvent(.valueChanged),
                    source: .just(.friends),
                    ordering: contained.tableView.topSegmentedControlValue.map { value -> Challenge.State.Ordering in
                        switch value {
                        case 0: return .new
                        case 1: return .popular
                        default: fatalError("dont know how to handle > 2 cases yet. Just new & popular")
                        }
                    },
                    challengeSelected: contained.tableView.itemSelected.map { $0.id }
                ),
                sinks: (
                    refreshControlVisible: contained.tableView.refreshControl!.rx.isRefreshing,
                    posts: contained.posts
                )
            )
        }
    }

}

extension Friends.ViewController: StoreSubscriber {
    func newState(state: App.State) {
    }
}

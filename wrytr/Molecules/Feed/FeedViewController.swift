import UIKit
import Cordux
import RxSwift
import RxCocoa
import RxLibrary
import Then

extension Feed {

    class ViewController: ContainerViewController<ChallengeViewController>, TabBarItemProviding {
        static let tabItem: UITabBarItem = UITabBarItem().then {
            $0.title = tr(.feedTitle)
            $0.image = UIImage(asset: .iconTabbarFeed)
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
                    source: .just(.everyone),
                    ordering: contained.tableView.topSegmentedControlValue
                        .ignore(-1)
                        .map { value -> Challenge.State.Ordering in
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
extension Feed.ViewController: Cordux.SubscriberType {
    typealias StoreSubscriberStateType = App.State

    func newState(_ state: App.State) {
    }
}

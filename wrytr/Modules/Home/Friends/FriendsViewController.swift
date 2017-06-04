import UIKit
import ReSwift
import RxSwift

extension Friends {

    class ViewController: ContainerViewController<ChallengeViewController>, TabBarItemProviding {
        static let tabItem: UITabBarItem = UITabBarItem().then {
            $0.title = tr(.friendTitle)
            $0.image = UIImage(asset: .iconTabbarFriends)
        }

        init(challengeViewController: ChallengeViewController = ChallengeViewController.fromStoryboard()) {
            super.init(viewController: challengeViewController)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError()
        }

        var controller: Challenge.Controller!

        private let disposeBag = DisposeBag()
        override func viewDidLoad() {
            super.viewDidLoad()

            self.contained.tableView.segmentedControlSectionTitles = ["New", "Popular"]

            self.controller = Challenge.Controller(
                inputs: (
                    pullToRefresh: contained.tableView.refreshControl!.rx.controlEvent(.valueChanged),
                    source: Variable<Challenge.State.Source>(.friends),
                    ordering: contained.tableView.topSegmentedControlValue
                        .ignore(-1)
                        .map { value -> Challenge.State.Ordering in
                        switch value {
                        case 0: return .new
                        case 1: return .popular
                        default: fatalError("dont know how to handle > 2 cases yet. Just new & popular")
                        }
                    },
                    challengeSelected: contained.tableView.itemSelected
                ),
                challengeSelected: { post in Routing(to: .home(.feed(.detail(post)))) }
            )

            self.controller.output.refreshControlVisible.asDriver()
                .drive(contained.tableView.refreshControl!.rx.isRefreshing)
                .disposed(by: self.disposeBag)

            self.controller.output.posts.asDriver()
                .drive(contained.tableView.posts)
                .disposed(by: self.disposeBag)
        }
    }

}

extension Friends.ViewController: StoreSubscriber {
    func newState(state: App.State) {
    }
}

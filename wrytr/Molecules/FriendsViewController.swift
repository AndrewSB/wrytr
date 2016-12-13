import UIKit
import Cordux
import RxSwift

extension Friends {

    class ViewController: ContainerViewController<ChallengeViewController> {
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
                    }
                ),
                sinks: (
                    refreshControlVisible: contained.tableView.refreshControl!.rx.refreshing,
                    posts: contained.posts
                )
            )
        }
    }

}

extension Friends.ViewController: Cordux.SubscriberType {
    typealias StoreSubscriberStateType = App.State

    func newState(_ state: App.State) {
    }
}

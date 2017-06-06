import UIKit
import RxSwift
import Then

extension Variable: Then {}

class ChallengeViewController: RxViewController {
    static func fromStoryboard(segmentedControlTitles: [String]) -> ChallengeViewController {
        return StoryboardScene.Challenge.instantiateChallengeVC().then {
            $0.tableView.segmentedControlSectionTitles = segmentedControlTitles
        }
    }

    @IBOutlet weak var tableView: ChallengeTableView!

    lazy var posts: Variable<[PostType]> = Variable([]).then {
        $0.asDriver().drive(self.tableView.posts).addDisposableTo(self.disposeBag)
    }
}

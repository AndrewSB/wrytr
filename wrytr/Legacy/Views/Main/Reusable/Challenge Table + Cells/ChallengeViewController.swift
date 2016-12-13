import UIKit
import RxSwift
import Then

extension Variable: Then {}

class ChallengeViewController: RxViewController {
    static func fromStoryboard() -> ChallengeViewController {
        return StoryboardScene.Challenge.instantiateChallengeVC()
    }

    @IBOutlet weak var tableView: ChallengeTableView!

    lazy var posts: Variable<[PostType]> = Variable([]).then {
        $0.asDriver().drive(self.tableView.posts).addDisposableTo(self.disposeBag)
    }
}

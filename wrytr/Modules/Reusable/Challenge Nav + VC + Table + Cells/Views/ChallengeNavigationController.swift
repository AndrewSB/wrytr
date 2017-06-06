import UIKit

class ChallengeNavigationController: UINavigationController {
    private var viewController: ChallengeViewController {
        guard let challengeVC = self.viewControllers[0] as? ChallengeViewController else { fatalError() }
        return challengeVC
    }

    var tableView: ChallengeTableView {
        viewController.loadViewIfNeeded()
        return viewController.tableView
    }

    static func fromStoryboard(segmentedControlTitles: [String]) -> ChallengeNavigationController {
        return StoryboardScene.Challenge.instantiateChallengeNav().then {
            $0.tableView.segmentedControlSectionTitles = segmentedControlTitles
        }
    }
}

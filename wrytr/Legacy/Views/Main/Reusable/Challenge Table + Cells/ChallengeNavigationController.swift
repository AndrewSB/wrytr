import UIKit

class ChallengeNavigationController: UINavigationController {
    static func fromStoryboard() -> ChallengeNavigationController {
        return StoryboardScene.Challenge.instantiateChallengeNav()
    }
}

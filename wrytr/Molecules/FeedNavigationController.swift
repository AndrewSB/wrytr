import UIKit

class FeedNavigationController: UINavigationController {
    static func fromStoryboard() -> FeedNavigationController {
        return StoryboardScene.Feed.instantiateFeedNav()
    }
}

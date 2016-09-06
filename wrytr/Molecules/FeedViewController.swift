import UIKit

extension Feed {
    typealias ViewController = FeedViewController
}

class FeedViewController: UIViewController {
    
}

extension Feed.ViewController {
    static func fromStoryboard() -> Feed.ViewController {
        let _ = StoryboardScene.Feed.instantiateFeedNav()
        let feedVC = StoryboardScene.Feed.instantiateFeed()
        
        return feedVC
    }
}

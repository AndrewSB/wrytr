import UIKit

import ReSwift
import ReSwiftRouter

class HomeTabBarController: ReSwiftTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [
            StoryboardScene.Feed.initialViewController(),
            StoryboardScene.Friends.initialViewController(),
            StoryboardScene.Create.initialViewController(),
            StoryboardScene.Me.initialViewController()
        ]
        
        tabBar.autoresizesSubviews = false
        tabBar.clipsToBounds = true
    }
}

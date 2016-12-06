import UIKit

extension Me {
    typealias ViewController = MeViewController
    typealias NavigationController = MeNavigationController
}

class MeViewController: UIViewController {

}

extension Me.ViewController {
    static func fromStoryboard() -> Me.ViewController {
        return StoryboardScene.Me.instantiateMeVC()
    }
}

class MeNavigationController: UINavigationController {
    static func fromStoryboard() -> Me.NavigationController {
        return StoryboardScene.Me.instantiateNavCon()
    }
}

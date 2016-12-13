import UIKit
import Cordux

extension Me {
    typealias ViewController = MeViewController
    typealias NavigationController = MeNavigationController
}

class MeViewController: UIViewController {

}

extension Me.ViewController: Cordux.SubscriberType {
    typealias StoreSubscriberStateType = App.State

    public func newState(_ subscription: App.State) {

    }
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

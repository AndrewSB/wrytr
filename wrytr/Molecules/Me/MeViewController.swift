import UIKit
import Cordux

extension Me {
    typealias ViewController = MeViewController
    typealias NavigationController = MeNavigationController
}

class MeViewController: UIViewController, TabBarItemProviding {

    @IBOutlet weak var challengeTableView: ChallengeTableView!
    @IBOutlet weak var challengeTableHeaderView: UIView!

    var profilePhoto: ProfilePhotoViewController!
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var elipses: UIButton!

    static let tabItem: UITabBarItem = UITabBarItem().then {
        $0.title = tr(.meTitle)
        $0.image = UIImage(asset: .iconTabbarProfile)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if segue.identifier == StoryboardSegue.Me.embedProfilePhoto.rawValue {
            guard let profilePhotoVC = segue.destination as? ProfilePhotoViewController else { fatalError() }
            self.profilePhoto = profilePhotoVC
        }
    }
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

import UIKit
import Cordux

extension Me {
    typealias ViewController = MeViewController
    typealias NavigationController = MeNavigationController
}

class MeViewController: UIViewController, TabBarItemProviding {

    @IBOutlet weak var challengeTableView: ChallengeTableView! {
        didSet {
            challengeTableView.tintColor = UIColor(named: .loginLoginBackground)
            challengeTableView.segmentedControlSectionTitles = ["All", "Created", "Responded"]
        }
    }
    @IBOutlet weak var challengeTableHeaderView: UIView! {
        didSet { challengeTableHeaderView.backgroundColor = UIColor(named: .loginLoginBackground) }
    }

    var profilePhoto: ProfilePhotoViewController! = nil {
        didSet {
            profilePhoto.view.backgroundColor = UIColor(named: .loginLoginBackground)
            profilePhoto.state.value = .none
        }
    }
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
        self.loadViewIfNeeded()

        switch subscription.authenticationState.user {
        case .loggedIn(let user):
            self.profilePhoto.user.value = user
            self.nameLabel.text = user.name

        default: fatalError("cant show this page if you aren't signed in")
        }
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

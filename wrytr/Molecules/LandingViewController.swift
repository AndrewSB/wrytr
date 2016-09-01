import UIKit
import Library
import Cordux

extension Landing {
    typealias ViewController = LandingViewController
}

class LandingViewController: UIViewController {
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var formContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var facebookButton: RoundedButton!
    @IBOutlet weak var twitterButton: RoundedButton!

    @IBOutlet weak var formHeader: UILabel!
    @IBOutlet weak var usernameLabel: InsettableTextField!
    @IBOutlet weak var emailLabel: InsettableTextField!
    @IBOutlet weak var passwordLabel: InsettableTextField!
    
    @IBOutlet weak var termsOfServiceButton: UIButton!

    @IBOutlet weak var actionButton: RoundedButton!
    
    @IBOutlet weak var helperLabel: UILabel!
    @IBOutlet weak var helperButton: RoundedButton!
}

extension LandingViewController {
    static func fromStoryboard() -> LandingViewController {
        return StoryboardScene.Login.instantiateLanding()
    }
}

extension LandingViewController: SubscriberType {
    typealias StoreSubscriberStateType = AppState

    func newState(_ state: AppState) {
        print("NEW STATE: \(state)")
    }
}

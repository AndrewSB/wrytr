import UIKit
import Library
import Cordux

extension Landing {
    typealias ViewController = LandingViewController
}

extension Landing.ViewController {
    static func fromStoryboard() -> LandingViewController {
        return StoryboardScene.Landing.instantiateLanding()
    }
}

class LandingViewController: ForwardingViewController, InterfaceProvidingPrimitive {
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var formContainer: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var facebookButton: RoundedButton!
    @IBOutlet weak var twitterButton: RoundedButton!
    
    @IBOutlet weak var formHeader: UILabel!
    @IBOutlet weak var usernameField: InsettableTextField!
    @IBOutlet weak var emailField: InsettableTextField!
    @IBOutlet weak var passwordField: InsettableTextField!
    
    @IBOutlet weak var termsOfServiceButton: UIButton!
    
    @IBOutlet weak var actionButton: RoundedButton!
    
    @IBOutlet weak var helperLabel: UILabel!
    @IBOutlet weak var helperButton: RoundedButton!
    
    var interface: Primitive!
    var onViewDidLoad: (() -> ())?
}

extension Landing.ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interface = IB(
            subtitle: subtitle,
            formContainer: formContainer,
            titleLabel: titleLabel,
            facebookButton: facebookButton,
            twitterButton: twitterButton,
            formHeader: formHeader,
            usernameField: usernameField,
            emailField: emailField,
            passwordField: passwordField,
            termsOfServiceButton: termsOfServiceButton,
            actionButton: actionButton,
            helperLabel: helperLabel,
            helperButton: helperButton
        )
        
        self.onViewDidLoad?()
    }
    
    struct IB: Primitive {
        let subtitle: UILabel
        let formContainer: UIStackView
        let titleLabel: UILabel
        let facebookButton: RoundedButton
        let twitterButton: RoundedButton
        let formHeader: UILabel
        let usernameField: InsettableTextField
        let emailField: InsettableTextField
        let passwordField: InsettableTextField
        let termsOfServiceButton: UIButton
        let actionButton: RoundedButton
        let helperLabel: UILabel
        let helperButton: RoundedButton
    }
}
import UIKit

import Library

import RxSwift
import RxCocoa

import ReSwift

import SafariServices

class LandingFormViewController: RxViewController {
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var socialContainerStackView: UIStackView!
    @IBOutlet weak var twitterSignup: RoundedButton! {
        didSet {
            twitterSignup.setTitle(title: tr(key: .LoginLandingTwitterbuttonTitle))
            
            twitterSignup.setImage(twitterSignup.imageView!.image?.withRenderingMode(.alwaysTemplate), for: .normal)
            twitterSignup.tintColor = UIColor(named: .TwitterBlue)
            twitterSignup.imageView!.contentMode = .scaleAspectFit

            twitterSignup.layer.borderWidth = 1
            twitterSignup.layer.borderColor = UIColor(named: .TwitterBlue).cgColor
        }
    }
    @IBOutlet weak var facebookSignup: RoundedButton! {
        didSet {
            facebookSignup.setTitle(title: tr(key: .LoginLandingFacebookbuttonTitle))
            
            facebookSignup.setImage(facebookSignup.imageView!.image!.withRenderingMode(.alwaysTemplate), for: .normal)
            facebookSignup.tintColor = UIColor(named: .FacebookBlue)
            facebookSignup.imageView!.contentMode = .scaleAspectFit
            
            facebookSignup.layer.borderWidth = 1
            facebookSignup.layer.borderColor = UIColor(named: .FacebookBlue).cgColor
        }
    }
    
    @IBOutlet weak var textOne: InsettableTextField! {
        didSet { styleTextField(textOne) }
    }
    @IBOutlet weak var textTwo: InsettableTextField!{
        didSet { styleTextField(textTwo) }
    }
    @IBOutlet weak var textThree: InsettableTextField!{
        didSet { styleTextField(textThree) }
    }
    
    @IBOutlet weak var tosAndRegisterStackView: UIStackView! {
        didSet {
            tosAndRegisterStackView.addEdgePadding(44)
        }
    }
    @IBOutlet weak var tosButton: UIButton! {
        didSet {
            let title = tosButton.titleLabel!.text!
            let range = NSRange.init(ofString: "Terms & Privacy Policy", inString: title)
            
            let attributedString = NSMutableAttributedString(string: title)
            attributedString.addAttributes([NSForegroundColorAttributeName: UIColor(named: .LoginLandingBackround)], range: range)
            
            self.tosButton.titleLabel!.lineBreakMode = .byWordWrapping
            UIView.performWithoutAnimation {
                self.tosButton.setAttributedTitle(attributedString, for: UIControlState())
            }
        }
    }
    @IBOutlet weak var actionButton: RoundedButton!
    
    @IBOutlet weak var loginSignupTitle: UILabel!
    @IBOutlet weak var loginSignupButton: RoundedButton! {
        didSet {
            loginSignupButton.layer.borderColor = UIColor(named: .LoginLandingBackround).cgColor
            loginSignupButton.layer.borderWidth = 1
        }
    }
    
    var state: State?
}

extension LandingFormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        facebookSignup.rx.tap
            .subscribe(onNext: {
                self.parent!.startLoading(.gray)
                store.dispatch(AuthenticationProvider.loginWithFacebook)
            })
            .addDisposableTo(disposeBag)
        
        twitterSignup.rx.tap
            .subscribe(onNext: {
                self.parent!.startLoading(.gray)
                store.dispatch(AuthenticationProvider.loginWithTwitter)
            })
            .addDisposableTo(disposeBag)
        
        actionButton.rx.tap
            .map { _ -> AuthenticationProvider.Params in
                let loginParams = AuthenticationProvider.Params.login(
                    email: self.textTwo.text ?? "",
                    password: self.textThree.text ?? ""
                )
                
                let signupParams = AuthenticationProvider.Params.signup(name: self.textOne.text ?? "", loginParams: loginParams)
                
                switch self.state! {
                case .Login:
                    return loginParams
                case .Signup:
                    return signupParams
                }
            }
            .subscribe(onNext: { authParams in
                store.dispatch(AuthenticationProvider.authWithFirebase(authParams))
            })
            .addDisposableTo(disposeBag)
        
        loginSignupButton.rx.tap.scan(State.Login) { (previousState, _) -> State in
                previousState == .Login ? .Signup : .Login
            }
            .map(NewLandingState.init)
            .subscribe(onNext: { store.dispatch($0) })
            .addDisposableTo(disposeBag)
        
        tosButton.rx.tap
            .subscribe(onNext: {
                let sVC = SFSafariViewController(url: URL(string: "https://google.com")!)
                self.present(sVC, animated: true, completion: nil)
            })
            .addDisposableTo(disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        [textOne, textTwo, textThree].forEach(styleTextField)
    }
}

extension LandingFormViewController: StoreSubscriber {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        store.subscribe(self) { state in return state.authenticationState.landingState }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        store.unsubscribe(self)
    }

    func newState(state: State) {
        self.state = state
        textOne.isHidden = state == .Login
        
        actionButton.setTitle("\(state.rawValue)", for: .normal)
        
        loginSignupButton.setTitle(state.not.rawValue, for: .normal)
        titleLabel.text = "\(state.rawValue) with Email"
        loginSignupTitle.text = state == .Login ? "Haven't registered yet?" : "Already registered?"
    }
    
    enum State: String {
        case Login
        case Signup
        
        var not: State {
            switch self {
            case .Login:
                return .Signup
            case .Signup:
                return .Login
            }
        }
    }
    
}

extension LandingFormViewController {
    
    fileprivate func styleTextField(_ tF: InsettableTextField) {
        tF.insetX = 8
        tF.insetY = 5
        
        tF.layer.borderWidth = 1
        tF.layer.borderColor = UIColor.lightGray.cgColor
        
        tF.layer.cornerRadius = 5
        tF.clipsToBounds = true
    }
    
}

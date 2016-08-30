import UIKit

import Library

import TwitterKit

import FBSDKLoginKit

import ReSwift
import ReSwiftRouter

import RxSwift
import RxCocoa

class LandingViewController: RxViewController {
    
    @IBOutlet weak var subtitle: UILabel! {
        didSet { subtitle.text = tr(key: .LoginLandingSubtitle) }
    }
    
    var landingForm: LandingFormViewController!
    @IBOutlet weak var formContainer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: .LoginLandingBackround)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == StoryboardSegue.Login.LandingForm.rawValue {
            landingForm = segue.destination as! LandingFormViewController
        }
        
    }
}

extension LandingViewController: StoreSubscriber {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self) { state in
            return state.authenticationState.loggedInState
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        store.unsubscribe(self)
    }
    
    func newState(state: LoggedInState) {
        self.stopLoading()
        switch state {
        case .errorLoggingIn(let error):
            let alert = UIAlertController(okayableTitle: "Couldn't log in 😔", message: error.localizedDescription)
            present(alert, animated: true, completion: { store.dispatch(UpdateLoggedInState(loggedInState: .notLoggedIn)) })
        case .loggedIn:
            print("Logged in")
        case .notLoggedIn:
            print("still not logged in")
        case .logout:
            assertionFailure("Cant logout from this screen")
        }
    }

}

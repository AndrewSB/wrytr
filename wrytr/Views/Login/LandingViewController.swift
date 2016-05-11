//
//  LandingViewController.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 3/18/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

import Library

import Twitter
import TwitterKit

import FBSDKLoginKit

import ReSwift
import ReSwiftRouter

import RxSwift
import RxCocoa

class LandingViewController: RxViewController {
    
    @IBOutlet weak var subtitle: UILabel! {
        didSet { subtitle.text = tr(.LoginLandingSubtitle) }
    }
    
    var landingForm: LandingFormViewController!
    @IBOutlet weak var formContainer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: .LoginLandingBackround)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == StoryboardSegue.Login.LandingForm.rawValue {
            landingForm = segue.destinationViewController as! LandingFormViewController
        }
        
    }
}

extension LandingViewController: StoreSubscriber {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self) { state in
            state.authenticationState.loggedInState
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        store.unsubscribe(self)
    }
    
    func newState(state: LoggedInState) {
        self.stopLoading()
        switch state {
        case .ErrorLoggingIn(let error):
            presentViewController(UIAlertController(okayableTitle: "Couldn't log in 😔", message: error.localizedDescription), animated: true, completion: nil)
        case .LoggedIn:
            print("Logged in")
        case .NotLoggedIn:
            print("still not logged in")
        case .Logout:
            assertionFailure("Cant logout from this screen")
        }
    }

}
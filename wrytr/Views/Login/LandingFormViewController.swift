//
//  LandingFormViewController.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 5/4/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

import Library

import RxSwift
import RxCocoa

import ReSwift

import SafariServices

class LandingFormViewController: RxViewController {
    @IBOutlet weak var containerStackView: UIStackView!
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var twitterSignup: RoundedButton! {
        didSet { twitterSignup.title = tr(.LoginLandingTwitterbuttonTitle) }
    }
    @IBOutlet weak var facebookSignup: RoundedButton! {
        didSet { facebookSignup.title = tr(.LoginLandingFacebookbuttonTitle) }
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
    
    @IBOutlet weak var tosButton: UIButton! {
        didSet {
            let title = tosButton.titleLabel!.text!
            let range = NSRange.init(ofString: "Terms & Privacy Policy", inString: title)
            
            let attributedString = NSMutableAttributedString(string: title)
            attributedString.addAttributes([NSForegroundColorAttributeName: UIColor(named: .LoginLandingBackround)], range: range)
            tosButton.setAttributedTitle(attributedString, forState: .Normal)
        }
    }
    
    @IBOutlet weak var loginSignupTitle: UILabel!
    @IBOutlet weak var loginSignupButton: RoundedButton! {
        didSet {
            loginSignupButton.layer.borderColor = UIColor(named: .LoginLandingBackround).CGColor
            loginSignupButton.layer.borderWidth = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facebookSignup.rx_tap
            .map(startLoading)
            .subscribeNext {
                store.dispatch(AuthenticationProvider.loginWithFacebook)
            }
            .addDisposableTo(disposeBag)
        
        twitterSignup.rx_tap
            .map(startLoading)
            .subscribeNext {
                store.dispatch(AuthenticationProvider.loginWithTwitter)
            }
            .addDisposableTo(disposeBag)
        
        loginSignupButton.rx_tap.scan(State.Login) { (previousState, _) -> State in
                previousState == .Login ? .Signup : .Login
            }
            .map(NewLandingState.init)
            .subscribeNext { store.dispatch($0) }
            .addDisposableTo(disposeBag)
        
        tosButton.rx_tap
            .subscribeNext {
                let sVC = SFSafariViewController(URL: NSURL(string: "https://google.com")!)
                self.presentViewController(sVC, animated: true, completion: nil)
            }
            .addDisposableTo(disposeBag)
    }
}

extension LandingFormViewController: StoreSubscriber {
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        store.subscribe(self) { state in
            state.authenticationState.landingState
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        store.unsubscribe(self)
    }

    func newState(state: State) {
        textOne.hidden = state == .Signup
        loginSignupButton.setTitle(state.rawValue, forState: .Normal)
        titleLabel.text = "\(state.rawValue) with Email"
    }
    
    enum State: String {
        case Login
        case Signup
    }
    
}

extension LandingFormViewController {
    
    private func styleTextField(tF: InsettableTextField) {
        tF.insetX = 8
        
        tF.layer.borderWidth = 1
        tF.layer.borderColor = UIColor.grayColor().CGColor
        
        tF.layer.cornerRadius = tF.frame.height / 2
        tF.clipsToBounds = true
    }
    
}
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
        didSet {
            textOne.insetX = 8
            textOne.layer.borderColor = UIColor.grayColor().CGColor
            textOne.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var textTwo: InsettableTextField!{
        didSet {
            textTwo.insetX = 8
            textTwo.layer.borderColor = UIColor.grayColor().CGColor
            textTwo.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var textThree: InsettableTextField!{
        didSet {
            textThree.insetX = 8
            textThree.layer.borderColor = UIColor.grayColor().CGColor
            textThree.layer.borderWidth = 1
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
        
        loginSignupButton.rx_tap.scan(false) { !$0.0 }
            .map { $0 ? State.Signup : State.Login }
            .subscribeNext(bindState)
            .addDisposableTo(disposeBag)
        
        delay(1) {
            self.twitterSignup.cornerRadius = 80
        }
    }
}

extension LandingFormViewController {

    private enum State: String {
        case Login
        case Signup
    }
    
    private func bindState(state: State) {
    
        textThree.hidden = state == .Login
        loginSignupButton.title = state.rawValue
    
    }
    
}
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
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var twitterSignup: RoundedButton! {
        didSet { twitterSignup.title = tr(.LoginLandingTwitterbuttonTitle) }
    }
    @IBOutlet weak var facebookSignup: RoundedButton! {
        didSet { facebookSignup.title = tr(.LoginLandingFacebookbuttonTitle) }
    }
    
    @IBOutlet weak var textOne: InsettableTextField! {
        didSet {
            textOne.layer.borderColor = UIColor.grayColor().CGColor
            textOne.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var textTwo: InsettableTextField!{
        didSet {
            textOne.layer.borderColor = UIColor.grayColor().CGColor
            textOne.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var textThree: InsettableTextField!{
        didSet {
            textOne.layer.borderColor = UIColor.grayColor().CGColor
            textOne.layer.borderWidth = 1
        }
    }
    
    
    @IBOutlet weak var loginSignupTitle: UILabel!
    @IBOutlet weak var loginSignupButton: RoundedButton!
    
    
    
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

    }
    
    
    
}

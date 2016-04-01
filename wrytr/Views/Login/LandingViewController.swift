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
    
    @IBOutlet weak var facebookSignup: RoundedButton! {
        didSet { facebookSignup.title = tr(.LoginLandingFacebookbuttonTitle) }
    }
    @IBOutlet weak var twitterSignup: RoundedButton! {
        didSet { twitterSignup.title = tr(.LoginLandingTwitterbuttonTitle) }
    }
    @IBOutlet weak var emailSignup: RoundedButton! {
        didSet { emailSignup.title = tr(.LoginLandingEmailbuttonTitle) }
    }
    @IBOutlet weak var login: RoundedButton! {
        didSet {
            login.title = tr(.LoginLandingLoginbuttonTitle)
            login.layer.borderColor = UIColor.whiteColor().CGColor
            login.layer.borderWidth = 2
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: .LoginLandingBackround)
        
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
        
        emailSignup?.rx_tap
            .bindNext { store.dispatch(SetRouteAction([landingRoute, signupRoute])) }
            .addDisposableTo(disposeBag)
        
        login.rx_tap
            .bindNext { store.dispatch(SetRouteAction([landingRoute, loginRoute])) }
            .addDisposableTo(disposeBag)
            
    }
    
    

}

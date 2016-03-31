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
        
        twitterSignup.rx_tap
            .map {
                self.view.userInteractionEnabled = false
                self.loader.show()
            }
            .flatMap(Twitter.sharedInstance().rx_login)
            .map { ["api.twitter.com": "\($0.authToken);\($0.authTokenSecret)"] }
            .subscribe { observer in
                switch observer {
                case .Error(let e):
                    print(e)
                case .Next(let loginDict):
                    print(loginDict)
                case .Completed:
                    self.view.userInteractionEnabled = true
                    self.loader.hide()
                }
            }
            .addDisposableTo(disposeBag)
        
        emailSignup.rx_tap
            .bindNext { store.dispatch(SetRouteAction([landingRoute, signupRoute])) }
            .addDisposableTo(disposeBag)
        
        login.rx_tap
            .bindNext { store.dispatch(SetRouteAction([landingRoute, loginRoute])) }
            .addDisposableTo(disposeBag)
            
    }

}

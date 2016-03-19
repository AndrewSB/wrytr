//
//  LandingViewController.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 3/18/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

import Library

class LandingViewController: UIViewController {
    
    @IBOutlet weak var subtitle: UILabel! { didSet { subtitle.text = tr(.LoginLandingSubtitle) } }
    
    @IBOutlet weak var facebookSignup: RoundedButton!
    @IBOutlet weak var twitterSignup: RoundedButton!
    @IBOutlet weak var emailSignup: RoundedButton!
    @IBOutlet weak var login: RoundedButton! {
        didSet {
            login.layer.borderColor = UIColor.whiteColor().CGColor
            login.layer.borderWidth = 2
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: .LoginLandingBackround)
    }

}

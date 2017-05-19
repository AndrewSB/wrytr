//
//  LandingModule.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 5/15/17.
//  Copyright © 2017 Andrew Breckenridge. All rights reserved.
//

import Foundation

class Landing {
    class Module: Routable {
        let landingViewController: ViewController

        var rootViewController: UIViewController {
            return landingViewController
        }

        var route: AppRoute {
            return .auth(.landing)
        }

        init(landingView: LandingViewController = LandingViewController.fromStoryboard()) {
            self.landingViewController = landingView
        }
    }
}

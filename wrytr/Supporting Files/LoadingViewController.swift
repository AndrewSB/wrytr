//
//  LoadingViewController.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 3/21/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

import Library

class LoadingViewController: UIViewController {

    override func loadView() {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        
        self.view = activityIndicator
    }
    
    var loadingView: UIActivityIndicatorView {
        get { return self.view as! UIActivityIndicatorView }
    }
    
    func show() {
        (self.view as! UIActivityIndicatorView).startAnimating()
    }

    func hide() {
        (self.view as! UIActivityIndicatorView).stopAnimating()
    }

}

extension UIViewController {
    
    func startLoading() {
        self.view.userInteractionEnabled = false
        self.loader.show()
    }

    func stopLoading() {
        self.view.userInteractionEnabled = true
        print(childViewControllers)
        self.loader.hide()
    }
    
    var loader: LoadingViewController {
        get {
            return childViewControllers
                .flatMap { $0 as? LoadingViewController }
                .first
                .getOrElse(self.createAndAddLoader())
        }
    }
    
    private func createAndAddLoader() -> LoadingViewController {
        print("adding new loader")
        let loader = LoadingViewController()
        self.addChildViewController(loader)
        loader.didMoveToParentViewController(self)
        loader.view.center = view.center
        view.addSubview(loader.view)
        return loader
    }
}

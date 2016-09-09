import UIKit

import Library

class LoadingViewController: UIViewController {

    override func loadView() {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
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
    
    func startLoading(_ loaderColor: UIColor?) {
        self.view.isUserInteractionEnabled = false
        self.loader.loadingView.color = loaderColor
        self.loader.show()
    }

    func stopLoading() {
        self.view.isUserInteractionEnabled = true
        print(childViewControllers)
        self.loader.hide()
    }
    
    var loader: LoadingViewController {
        get {
            return childViewControllers
                .flatMap { $0 as? LoadingViewController }
                .first ?? self.createAndAddLoader()
        }
    }
    
    fileprivate func createAndAddLoader() -> LoadingViewController {
        print("adding new loader")
        let loader = LoadingViewController()
        self.addChildViewController(loader)
        loader.didMove(toParentViewController: self)
        loader.view.center = view.center
        view.addSubview(loader.view)
        return loader
    }
}

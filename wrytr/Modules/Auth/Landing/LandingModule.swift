import UIKit

class Landing {
    class Module: Routable {
        private let landingViewController: ViewController

        var rootViewController: UIViewController {
            return landingViewController
        }

        var route: AppRoute {
            return .auth(.landing)
        }

        init(landingView: LandingViewController = LandingViewController.fromStoryboard(authOption: .register)) {
            self.landingViewController = landingView
        }
    }
}

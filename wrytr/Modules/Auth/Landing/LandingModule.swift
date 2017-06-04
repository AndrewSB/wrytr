import UIKit
import ReSwift

class Landing {
    class Module: Routable {
        private let landingViewController: ViewController

        var rootViewController: UIViewController {
            return landingViewController
        }

        var route: AppRoute {
            return .auth(.landing)
        }

        init(landingView: LandingViewController = LandingViewController.fromStoryboard(authOption: .register), store: DefaultStore = App.current.store) {
            self.landingViewController = landingView

            store.subscribe(self.landingViewController)
            self.landingViewController.newState(state: store.state, animated: false)
        }
    }
}

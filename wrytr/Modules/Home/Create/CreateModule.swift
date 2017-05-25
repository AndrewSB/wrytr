import UIKit

class Create {
    class Module: Routable {
        private let createNavigationController: Create.NavigationController

        var rootViewController: UIViewController {
            return createNavigationController
        }

        var route: AppRoute { return .home(.create) }

        init(createNav: Create.NavigationController = NavigationController.fromStoryboard()) {
            self.createNavigationController = createNav
        }
    }
}

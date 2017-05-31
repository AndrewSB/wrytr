import UIKit

class Me { // swiftlint:disable:this type_name
    class Module: Routable {
        private let meNavigationController: NavigationController

        var rootViewController: UIViewController {
            return meNavigationController
        }

        var route: AppRoute { return .home(.me) }

        init(meNav: Me.NavigationController = NavigationController.fromStoryboard()) {
            self.meNavigationController = meNav
        }
    }
}

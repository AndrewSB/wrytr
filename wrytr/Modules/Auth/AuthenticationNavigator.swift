import UIKit

class Authentication {
    class Navigator: ChildNavigation {
        var child: ChildNavigation? = .none

        /// This is filled in by the parent (`RootNavigator`) and is invoked when the child wants to present a view
        var presentationContext: ((UIViewController) -> Void)!

        private let landing: Routable = Landing.Module()

        init() {}

        func activate(route: AppRoute) {
            switch route {
            case .auth(.landing):
                presentationContext(landing.rootViewController)

            default:
                fatalError("Auth Navigator hasn't been implemented to handle \(route)")
            }
        }

        func add(child: ChildNavigation) {
            fatalError("unimplemented")
        }

    }
}

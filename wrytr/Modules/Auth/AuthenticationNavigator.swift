import UIKit

class Authentication {
    class Navigator: ChildNavigation {
        var child: ChildNavigation? = .none

        /// This is filled in by the parent (`RootNavigator`) and is invoked when the child wants to present a view
        var presentationContext: ((UIViewController) -> Void)!


        init() {}


        func activate(routable: Routable) {
            presentationContext(routable.rootViewController)
        }

        func add(child: ChildNavigation) {
            fatalError("unimplemented")
        }

    }
}

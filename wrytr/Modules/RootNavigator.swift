import UIKit

class RootNavigator: MainNavigation {
    var child: ChildNavigation?

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        window.rootViewController = UIViewController()
    }

    func add(child: ChildNavigation) {
        self.child = child
        self.child!.presentationContext = { [weak self] childView in
            self!.window.rootViewController = childView
        }
    }

    func activate(route: AppRoute) {
        guard let leafChild = self.recursiveLastChild as? ChildNavigation else {
            /// If we don't have a child, let's add a relevant child
            self.add(child: {
                switch route {
                case .auth:
                    return Authentication.Navigator()
                case .home:
                    return Home.Navigator()
                }
            }())

            // and that means (hopefully) we'll be able to activate that child as a leaf, so lets recurse :)
            return activate(route: route)
        }

        leafChild.activate(route: route)
    }
}

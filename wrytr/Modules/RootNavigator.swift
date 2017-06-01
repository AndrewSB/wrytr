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

    @discardableResult private func remove(child: ChildNavigation?) -> ChildNavigation {
        var parent: MainNavigation? = self
        var pointer: ChildNavigation? = self.child

        while pointer !== child {
            parent = child
            pointer = child?.child
        }
        parent?.child = nil

        guard let childPointer = pointer else {
            fatalError("tried to remove a child that doesn't exist in the hierarchy")
        }

        return childPointer
    }

    func activate(route: AppRoute) {
        let child = ensureChildExistsOrAddChild(for: route)

        if childIsCorrectParent(for: route) {
            child.activate(route: route)
        } else {
            self.remove(child: child)
            activate(route: route)
        }
    }

    private func ensureChildExistsOrAddChild(for route: AppRoute) -> ChildNavigation {
        guard let leafChild = self.recursiveLastChild as? ChildNavigation else {
            let child: ChildNavigation = {
                switch route {
                case .auth:
                    return Authentication.Navigator()
                case .home:
                    return Home.Navigator()
                }
            }()

            self.add(child: child)
            return child
        }

        return leafChild
    }

    private func childIsCorrectParent(for route: AppRoute) -> Bool {
        guard let child = self.child else {
            return false
        }

        switch route {
        case .auth:
            return type(of: child) == Authentication.Navigator.self
        case .home:
            return type(of: child) == Home.Navigator.self
        }
    }
}

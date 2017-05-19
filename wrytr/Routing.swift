import Foundation
import protocol ReSwift.Action

struct Routing: Action, Equatable {

    let route: AppRoute

    init(to route: AppRoute) {

        self.route = route
    }
}

func == (lhs: Routing, rhs: Routing) -> Bool {
    return lhs.route == rhs.route
}

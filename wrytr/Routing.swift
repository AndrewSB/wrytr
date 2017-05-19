import Foundation
import protocol ReSwift.Action

public struct Routing: Action, Equatable {

    public let route: AppRoute

    public init(to route: AppRoute) {

        self.route = route
    }
}

public func ==(lhs: Routing, rhs: Routing) -> Bool {

    return lhs.route == rhs.route
}

import Foundation
import ReSwift

// swiftlint:disable identifier_name

struct Routing: Action {

    let route: AppRoute

    init(to route: AppRoute) {
        self.route = route
    }
}
extension Routing: Equatable {

    static func == (lhs: Routing, rhs: Routing) -> Bool {
        return lhs.route == rhs.route
    }

    static var reduce: Reducer<AppRoute> {
        return { action, route in
            let route = route ?? .none

            switch action {
            case let routingAction as Routing:
                return routingAction.route

            case let authAction as Authentication.Action:
                switch authAction {
                case .loggedIn:
                    return .home(.feed(.table))
                case .loggedOut:
                    return .auth(.landing)
                default:
                    return route
                }

            case Post.CreateAction.createdPost(let post):
                fatalError("I'm not sure how to figure out if the post was created on friends or feed below")
                return .home(.feed(.detail(post)))
            default:
                return route
            }
        }
    }
}

enum AppRoute: StateType, Equatable {
    case auth(AuthRoute)
    case home(HomeRoute)
    case none

    init() { self = .none }

    static func == (lhs: AppRoute, rhs: AppRoute) -> Bool {
        switch (lhs, rhs) {
        case (.auth(let lA), .auth(let rA)):
            return lA == rA
        case (.home(let lH), .home(let rH)):
            return lH == rH
        case (.none, .none):
            return true
        case (.auth, .home), (.auth, .none), (.home, .auth), (.home, .none), (.none, .auth), (.none, .home):
            return false
        }
    }
}

enum AuthRoute: Equatable {
    case landing
}

enum HomeRoute: Equatable {
    case feed(ChallengeRoute)
    case friends(ChallengeRoute)
    case create
    case me

    static func == (lhs: HomeRoute, rhs: HomeRoute) -> Bool {
        switch (lhs, rhs) {
        case (.feed(let lF), .feed(let rF)):
            return lF == rF
        case (.friends(let lF), .feed(let rF)):
            return lF == rF
        case (.create, .create):
            return true
        case (.me, .me):
            return true
        default:
            return false
        }
    }
}

enum ChallengeRoute: Equatable {
    case table
    case detail(PostType)

    static func == (lhs: ChallengeRoute, rhs: ChallengeRoute) -> Bool {
        switch (lhs, rhs) {
        case (.table, .table):
            return true
        case (.detail(let lD), .detail(let rD)):
            return lD == rD
        case (.table, .detail), (.detail, .table):
            return false
        }
    }
}

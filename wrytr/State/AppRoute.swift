import Foundation
import ReSwift

// swiftlint:disable identifier_name

enum AppRoute: StateType {
    case auth(AuthRoute)
    case home(HomeRoute)
}

enum AuthRoute {
    case landing
}

enum HomeRoute {
    case feed(FeedRoute)
    case friends
    case create
    case me
}

enum FeedRoute {
    case table
    case detail(PostType)
}

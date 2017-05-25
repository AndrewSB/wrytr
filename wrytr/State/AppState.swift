import ReSwift
import RxCocoa

extension App {
    struct State: StateType {
        var route = AppRoute.default

        var authenticationState = Authentication.State()
        var postState = Post.State()

        var landingState = Landing.State()
        var feedState = Feed.State()
        var friendsState = Friends.State()
        var createState = Create.State()
        var meState = Me.State()
    }
}

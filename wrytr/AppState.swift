import Cordux

typealias Store = Cordux.Store<AppState>

struct AppState: StateType {
    var route: Route = []
    var landingState = Landing.State()
    var feedState = Feed.State()
    var authenticationState = Authentication.State()
    var postState = Post.State()
}

fileprivate let viewModelReducers = CombinedReducer([
    Landing.Reducer(),
    Feed.Reducer()
])

let appReducer = CombinedReducer([
    Authentication.Reducer(),
    Post.Reducer(),
    viewModelReducers
])

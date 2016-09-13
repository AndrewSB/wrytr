import Cordux

typealias Store = Cordux.Store<AppState>

struct AppState: StateType {
    var route: Route = []
    var landingState = Landing.ViewModel()
    var feedState = Feed.ViewModel()
    var authenticationState = Authentication.State()
    var postState = Post.State()
}

fileprivate let viewModelReducers = CombinedReducer([
    Landing.ViewModel.Reducer(),
    Feed.ViewModel.Reducer()
])

let appReducer = CombinedReducer([
    Authentication.Reducer(),
    Post.Reducer(),
    viewModelReducers
])

import Cordux

let store = Store(initialState: App.State(), reducer: appReducer, middlewares: [])

typealias Store = Cordux.Store<App.State>

class App {
    struct State: StateType {
        var route: Route = []
        var landingState = Landing.State()
        var feedState = Feed.State()
        var authenticationState = Authentication.State()
        var postState = Post.State()
    }
}

fileprivate let viewModelReducers = CombinedReducer([
    Landing.Reducer(),
    Feed.Reducer(),
    Create.Reducer(),
    Me.Reducer()
])

let appReducer = CombinedReducer([
    Authentication.Reducer(),
    Post.Reducer(),
    viewModelReducers
])

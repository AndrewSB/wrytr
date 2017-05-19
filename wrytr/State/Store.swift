import ReSwift

typealias DefaultStore = Store<App.State>

extension Store where State == App.State {
    static func create() -> DefaultStore {
        return Store(reducer: appReducer, state: .none)
    }
}

fileprivate let appReducer: Reducer<App.State> = { action, state in
    var state = state

    var route: AppRoute? = .none

    var authenticationState = Authentication.State()
    var postState = Post.State()

    var landingState = Landing.State()
    var feedState = Feed.State()
    var friendsState = Friends.State()
    var createState = Create.State()
    var meState = Me.State()

}

private var reducers: [Reducer] = [
    // top level
    Authentication.reducer,
    Post.reducer,

    // view models
    Landing.reducer,
    Feed.reducer,
    Friends.reducer,
    Create.reducer,
    Me.reducer
]

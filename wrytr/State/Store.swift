import ReSwift

typealias DefaultStore = Store<App.State>

extension Store where State == App.State {
    static func create() -> DefaultStore {
        return Store(reducer: appReducer, state: .none)
    }
}

fileprivate let appReducer: Reducer<App.State> = { action, state in
    let state = state ?? App.State()

    return App.State(
        route: Routing.reduce(action, state.route),

        authenticationState: Authentication.reduce(action, state.authenticationState),
        postState: Post.reduce(action, state.postState),

        landingState: Landing.reduce(action, state.landingState),
        feedState: Feed.reduce(action, state.feedState),
        friendsState: Friends.reduce(action, state.friendsState),
        createState: Create.reduce(action, state.createState),
        meState: Me.reduce(action, state.meState)
    )
}

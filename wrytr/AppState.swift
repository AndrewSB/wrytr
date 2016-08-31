import Cordux

typealias Store = Cordux.Store<AppState>

struct AppState: StateType {
    var route: Route = []
    var authenticationState: Authentication.State = .unauthenticated
}

final class AppReducer: Reducer {
    func handleAction(_ action: Action, state: AppState) -> AppState {
        var state = state

        return State(
            route: state.route,
            authenticationState: Authentication.Reducer.handleAction(action, state: state.authenticationState)
        )
    }
}

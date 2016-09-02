import Cordux

typealias Store = Cordux.Store<AppState>

struct AppState: StateType {
    var route: Route = []
    var landingState: Landing.ViewModel = Landing.ViewModel.initialState
    var authenticationState: Authentication.State = .unauthenticated
}

final class AppReducer: Reducer {
    func handleAction(_ action: Action, state: AppState) -> AppState {
        return State(
            route: state.route,
            landingState: Landing.ViewModel.reduce(state: state.landingState, action: action),
            authenticationState: state.authenticationState
        )
    }
}

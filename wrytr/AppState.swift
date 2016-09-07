import Cordux

typealias Store = Cordux.Store<AppState>

struct AppState: StateType {
    var route: Route = []
    var landingState: Landing.ViewModel = Landing.ViewModel.initial
    var authenticationState: Authentication.State = Authentication.State.initial
}

final class AppReducer: Reducer {
    func handleAction(_ action: Action, state: AppState) -> AppState {
        return State(
            route: state.route,
            landingState: Landing.ViewModel.handleAction(action: action, state: state.landingState),
            authenticationState: Authentication.Reducer.handleAction(action, state: state.authenticationState)
        )
    }
}

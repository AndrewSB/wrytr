import Cordux

typealias Store = Cordux.Store<AppState>

struct AppState: StateType {
    var route: Route = []
    var landingState = Landing.ViewModel()
    var authenticationState = Authentication.State()
}

let appReducer = CombinedReducer([
    Authentication.Reducer(),
    Landing.ViewModel.Reducer(),
])

import ReSwift
import Cordux

typealias Store = Cordux.Store<AppState>

struct AppState: Cordux.StateType {
    var route: Route = []
    var authenticationState: AuthenticationState
}

enum AuthenticationState: ReSwift.StateType {
    case unauthenticated
    case authenticated
}

enum AuthenticationAction: ReSwift.Action {
    case signIn
    case signOut
}

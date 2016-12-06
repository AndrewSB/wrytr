import RxSwift
import ReSwift
import Cordux

fileprivate let neverDisposeBag = DisposeBag()

extension Authentication {

    struct State: ReSwift.StateType {
        var user: UserType? = User.Service.authedUser
        var error: PresentableError? = nil
    }

    enum Action: Cordux.Action {
        case loggingIn
        case loggedIn(UserType)
        case errorLoggingIn(PresentableError)
        case loggedOut

        func facebookLogin() -> AsyncAction {
            return { state, store in
                store.dispatch(Action.loggingIn)
                neverDisposeBag += User.Service.facebookAuth().subscribe(authResponder)
            }
        }

        func twitterLogin() -> AsyncAction {
            return { state, store in
                store.dispatch(Action.loggingIn)
                neverDisposeBag += User.Service.twitterAuth().subscribe(authResponder)
            }
        }

        func signup(name: String, email: String, password: String) -> AsyncAction {
            return { state, store in
                store.dispatch(Action.loggingIn)
                neverDisposeBag += User.Service.signup(name: name, email: email, password: password).subscribe(authResponder)
            }
        }

        func login(email: String, password: String) -> AsyncAction {
            return { state, store in
                store.dispatch(Action.loggingIn)
                neverDisposeBag += User.Service.login(email: email, password: password).subscribe(authResponder)
            }
        }

        private func authResponder(_ observer: Event<UserType>) {
            switch event {
            case .next(let user):   store.dispatch(Action.loggedIn(user))
            case .error(let error): store.dispatch(Action.errorLoggingIn(error as! PresentableError))
            case .completed:        break

            }
        }
    }
}

extension Authentication {
    final class Reducer: Cordux.Reducer {
        public func handleAction(_ action: Cordux.Action, state: AppState) -> AppState {
            var state = state

            switch action {
            case let authAction as Authentication.Action:
                state.authenticationState = self.handleAction(authAction, state: state.authenticationState)
            default:
                break
            }

            return state
        }

        private func handleAction(_ action: Authentication.Action, state: App.State) -> App.State {
            var state = state

            switch action {
            case .loggedIn(let user):
                state.authenticationState.user = user
                state.authenticationState.error = nil
                state.route = [App.Coordinator.RouteSegment.home.rawValue]

            case .errorLoggingIn(let error):
                state.authenticationState.error = error

            case .loggedOut:
                state.authenticationState.error = nil
                state.authenticationState.user = nil
                state.route = [App.Coordinator.RouteSegment.auth.rawValue]

            }

            return state
        }
    }
}

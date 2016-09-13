import RxSwift
import ReSwift
import Cordux

fileprivate let neverDisposeBag = DisposeBag()

extension Authentication {

    struct State: ReSwift.StateType {
        var user: UserType? = nil
        var error: PresentableError? = nil
    }

    enum Action: Cordux.Action {
        case loggingIn
        case loggedIn(UserType)
        case errorLoggingIn(PresentableError)
        case loggedOut
    }

    static func signIn(_ params: User.Service.Auth) -> AsyncAction {
        return { state, store in
            store.dispatch(Action.loggingIn)

            User.Service.auth(params: params).subscribe {
                switch $0 {
                case .next(let user):
                    store.dispatch(Action.loggedIn(user))
                case .error(let error):
                    store.dispatch(Action.errorLoggingIn(error as! PresentableError))
                case .completed:
                    break
                }
            }.addDisposableTo(neverDisposeBag)

            return nil
        }

    }
}

extension Authentication {
    final class Reducer: Cordux.Reducer {
        public func handleAction(_ action: Cordux.Action, state: AppState) -> AppState {
            var state = state
            print("dispatched: \(action)")

            switch action {
            case let authAction as Authentication.Action:
                state.authenticationState = self.handleAction(authAction, state: state.authenticationState)
            default:
                break
            }

            return state
        }

        private func handleAction(_ action: Authentication.Action, state: Authentication.State) -> Authentication.State {
            var state = state

            switch action {
            case .loggingIn:
                break
            case .loggedIn(let user):
                state.user = user
            case .errorLoggingIn(let error):
                state.error = error
            case .loggedOut:
                state.error = nil
                state.user = nil
            }

            return state
        }
    }
}

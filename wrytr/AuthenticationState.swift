import RxSwift
import ReSwift
import Cordux

extension Authentication {
    struct State: ReSwift.StateType {
        var user: UserType?
        var error: PresentableError?

        static let initial = State(user: nil, error: nil)
    }

    enum Action: Cordux.Action {
        case loggedIn(UserType)
        case errorLoggingIn(PresentableError)
        case loggedOut
    }

    static func signIn(_ params: User.Service.Auth) -> (Disposable?, AsyncAction) {
        var requestDisposable: Disposable! = nil
        let asyncAction: AsyncAction = { state, store in
            requestDisposable = User.Service.auth(params: params).subscribe {
                switch $0 {
                case .next(let user):
                    store.dispatch(Action.loggedIn(user))
                case .error(let error):
                    store.dispatch(Action.errorLoggingIn(error as! PresentableError))
                case .completed:
                    break
                }
            }

            return nil
        }

        return (requestDisposable, asyncAction)

    }
}

extension Authentication {
    class Reducer {
        typealias State = Authentication.State

        public static func handleAction(_ action: Cordux.Action, state: State) -> State {
            var state = state

            guard let action = action as? Authentication.Action else { return state }

            switch action {
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

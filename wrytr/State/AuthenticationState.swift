import RxSwift
import ReSwift

fileprivate let neverDisposeBag = DisposeBag()

extension Authentication {

    struct State: ReSwift.StateType {
        var user: Auth? = .none

        enum Auth {
            case loggedOut
            case loggingIn
            case failedToLogin(PresentableError)
            case loggedIn(UserType)

            var userModelIfLoggedIn: UserType? {
                switch self {
                case .loggedIn(let model):  return model
                default:                    return nil
                }
            }
        }
    }

    enum Action: Cordux.Action {
        case loggingIn
        case loggedIn(UserType)
        case errorLoggingIn(PresentableError)
        case loggedOut

        static func facebookLogin() -> Cordux.Store<App.State>.AsyncAction {
            return { state, store in
                store.dispatch(Action.loggingIn)
                User.Service.facebookAuth().subscribe(authResponder).addDisposableTo(neverDisposeBag)
                return nil
            }
        }

        static func twitterLogin() -> Cordux.Store<App.State>.AsyncAction {
            return { state, store in
                store.dispatch(Action.loggingIn)
                User.Service.twitterAuth().subscribe(authResponder).addDisposableTo(neverDisposeBag)
                return nil
            }
        }

        static func login(email: String, password: String) -> Cordux.Store<App.State>.AsyncAction {
            return { state, store in
                store.dispatch(Action.loggingIn)
                User.Service.login(email: email, password: password).subscribe(authResponder).addDisposableTo(neverDisposeBag)
                return nil
            }
        }

        static func signup(name: String, email: String, password: String) -> Cordux.Store<App.State>.AsyncAction {
            return { state, store in
                store.dispatch(Action.loggingIn)
                 User.Service.signup(name: name, email: email, password: password).subscribe(authResponder).addDisposableTo(neverDisposeBag)
                return nil
            }
        }

        private static func authResponder(_ event: Event<UserType>) {
            switch event {
            case .next(let user):   appStore.dispatch(Action.loggedIn(user))
            case .error(let error): appStore.dispatch(Action.errorLoggingIn(error as PresentableError))
            case .completed:        break

            }
        }
    }
}

extension Authentication {
    final class Reducer: Cordux.Reducer {
        public func handleAction(_ action: Cordux.Action, state: App.State) -> App.State {
            var state = state

            switch action {
            case let authAction as Authentication.Action:
                switch authAction {
                case .loggingIn:
                    state.authenticationState.user = .loggingIn

                case .loggedIn(let user):
                    state.authenticationState.user = .loggedIn(user)
                    state.route = [App.Coordinator.RouteSegment.home.rawValue]

                case .errorLoggingIn(let error):
                    state.authenticationState.user = .failedToLogin(error)

                case .loggedOut:
                    state.authenticationState.user = .loggedOut
                    state.route = [App.Coordinator.RouteSegment.auth.rawValue]
                }

            default:
                break
            }

            return state
        }

    }
}

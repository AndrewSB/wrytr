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

    enum Action: ReSwift.Action {
        case loggingIn
        case loggedIn(UserType)
        case errorLoggingIn(PresentableError)
        case loggedOut

        static func facebookLogin() -> DefaultStore.AsyncAction {
            return { state, store in
                store.dispatch(Action.loggingIn)
                User.Service.facebookAuth()
                    .subscribe { event in
                        authResponder(store: App.current.store, event)
                    }
                    .addDisposableTo(neverDisposeBag)

                return nil
            }
        }

        static func twitterLogin() -> DefaultStore.AsyncAction {
            return { state, store in
                store.dispatch(Action.loggingIn)
                User.Service.twitterAuth()
                    .subscribe { event in
                        authResponder(store: App.current.store, event)
                    }
                    .addDisposableTo(neverDisposeBag)
                return nil
            }
        }

        static func login(email: String, password: String) -> DefaultStore.AsyncAction {
            return { state, store in
                store.dispatch(Action.loggingIn)
                User.Service.login(email: email, password: password)
                    .subscribe { event in
                        authResponder(store: App.current.store, event)
                    }
                    .addDisposableTo(neverDisposeBag)
                return nil
            }
        }

        static func signup(name: String, email: String, password: String) -> DefaultStore.AsyncAction {
            return { state, store in
                store.dispatch(Action.loggingIn)
                User.Service.signup(name: name, email: email, password: password)
                    .subscribe { event in
                        authResponder(store: App.current.store, event)
                    }
                    .addDisposableTo(neverDisposeBag)
                return nil
            }
        }

        private static func authResponder(store: Store<App.State>, _ event: Event<UserType>) {
            switch event {
            case .next(let user):   store.dispatch(Action.loggedIn(user))
            case .error(let error): store.dispatch(Action.errorLoggingIn(error as PresentableError))
            case .completed:        break

            }
        }
    }
}

extension Authentication {
    var reducer: Reducer<Authentication.State> {
        return { action, state in
            var state = state ?? Authentication.State()
            guard let authAction = action as? Authentication.Action else {
                return state
            }

            switch authAction {
                case .loggingIn:
                    state.user = .loggingIn

                case .loggedIn(let user):
                    state.user = .loggedIn(user)

                case .errorLoggingIn(let error):
                    state.user = .failedToLogin(error)

                case .loggedOut:
                    state.user = .loggedOut
            }

            return state
        }
    }
}

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
    static var reduce: Reducer<Authentication.State> {
        return { action, state in
            var state = state ?? Authentication.State()

            switch action {
            /// Handle all authentication actions
            case let authAction as Authentication.Action:
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

            case Landing.Action.dismissError:
                guard case .failedToLogin = state.user! else {
                    fatalError("this was an assumption I had when I refactored: that the landing dismissError action would only happen if in the failedToLogin state. Untrue?")
                }
                switch state.user! {
                case .loggedIn: fatalError() // dismissing an error is a no-op if you're loggedIn
                default:
                    state.user = .loggedOut
                }


            default:
                break
            }

            return state
        }
    }
}

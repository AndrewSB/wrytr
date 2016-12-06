import Cordux

class Landing {
    struct State {
        var option: Option = .login
        var loading: Bool = false
        var error: PresentableError? = nil

        enum Option {
            case login
            case register

            var other: Option {
                switch self {
                case .login:    return .register
                case .register: return .login
                }
            }

            var worded: String {
                switch self {
                case .login:    return tr(.loginLandingLoginTitle)
                case .register: return tr(.loginLandingRegisterTitle)
                }
            }

            var helperText: String {
                switch self {
                case .login:    return tr(.loginLandingHelperLoginTitle)
                case .register: return tr(.loginLandingHelperRegisterTitle)
                }
            }
        }
    }

    enum Action: Cordux.Action {
        case updateOption(State.Option)
        case dismissError
    }
}

extension Landing {

    final class Reducer: Cordux.Reducer {

        func handleAction(_ action: Cordux.Action, state: Landing.State) -> Landing.State {
            var state = state

            switch action {
            case Authentication.Action.loggingIn:
                state.loading = true

            case Authentication.Action.loggedIn:
                state.loading = false

            case Authentication.Action.errorLoggingIn(let error):
                state.loading = false
                state.error = error

            case let action as Landing.Action:
                switch action {
                case .updateOption(let newOption):
                    state.option = newOption
                case .dismissError:
                    state.error = nil
                }

            default:
                break
            }

            return state
        }
    }
}
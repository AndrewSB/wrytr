import Cordux

class Landing {
    struct State {
        var option: Option = .login

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

        func handleAction(_ action: Cordux.Action, state: App.State) -> App.State {
            var state = state

            switch action {

            case let action as Landing.Action:
                switch action {
                case .updateOption(let newOption):
                    state.landingState.option = newOption
                case .dismissError:
                    switch state.authenticationState.user {
                    case .loggedIn: fatalError() // dismissing an error is a no-op if you're loggedIn
                    default:
                        state.authenticationState.user = .loggedOut
                    }
                }

            default:
                break
            }

            return state
        }
    }
}

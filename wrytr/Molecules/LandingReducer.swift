import Cordux

class Landing {
    struct State {
        var option: Option = .login
        var loading: Bool = false
        var error: PresentableError? = nil

        enum Option {
            case login
            case register
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
                //state.route = [AppCoordinator.RouteSegment.home.rawValue] // TODO: what do we do here? We can't access the route

            case Authentication.Action.errorLoggingIn(let error):
                state.loading = false
                state.error = error

            case let action as Landing.Action:
                // TODO: refactor this
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

        private func handleLandingAction(action: Landing.Action, state: Landing.ViewModel) -> Landing.State {
            var state = state

            switch action {
            case .updateOption(let newOption):
                state.option = newOption
            case .dismissError:
                state.error = nil
            }

            return state
        }
    }
}

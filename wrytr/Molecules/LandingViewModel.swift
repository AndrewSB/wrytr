import Cordux

extension Landing {
    struct ViewModel {
        var option: Option = .login
        var loading: Bool = false
        var error: PresentableError? = nil
    }

    enum Action: Cordux.Action {
        case updateOption(ViewModel.Option)
        case dismissError
    }
}

extension Landing.ViewModel {
    enum Option {
        case login
        case register
    }
}

extension Landing.ViewModel {

    final class Reducer: Cordux.Reducer {

        func handleAction(_ action: Action, state: AppState) -> AppState {
            var state = state

            switch action {
            case Authentication.Action.loggingIn:
                state.landingState.loading = true

            case Authentication.Action.loggedIn:
                state.landingState.loading = false
                state.route = [AppCoordinator.RouteSegment.home.rawValue]

            case Authentication.Action.errorLoggingIn(let error):
                state.landingState.loading = false
                state.landingState.error = error
                print("BRUH")
                print(state.landingState.loading)


            case let action as Landing.Action:
                state.landingState = self.handleLandingAction(action: action, state: state.landingState)

            default:
                break
            }

            return state
        }

        private func handleLandingAction(action: Landing.Action, state: Landing.ViewModel) -> Landing.ViewModel {
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

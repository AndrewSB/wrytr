import Cordux

extension Landing {
    struct ViewModel {
        var option: Option
        var loading: Bool
        var error: PresentableError?

        static let initial = Landing.ViewModel(option: .login, loading: false, error: nil)
    }

    enum Action: Cordux.Action {
        case updateOption(ViewModel.Option)
        case startLoading
        case stopLoading
        case showError(PresentableError)
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
    static func handleAction(action: Cordux.Action, state: Landing.ViewModel) -> Landing.ViewModel {
        var state = state

        switch action {
        case Authentication.Action.loggedIn(let user):
            print("logged in with \(user)")
            state.loading = false
        case Authentication.Action.errorLoggingIn(let error):
            state.error = error
            state.loading = false
        case Authentication.Action.loggedOut:
            break
        case let action as Landing.Action:
            return self.handleLandingAction(action: action, state: state)
        default:
            break
        }

        return state
    }

    private static func handleLandingAction(action: Landing.Action, state: Landing.ViewModel) -> Landing.ViewModel {
        var state = state

        switch action {
        case .updateOption(let newOption):
            state.option = newOption
        case .startLoading:
            state.loading = true
        case .stopLoading:
            state.loading = false
        case .showError(let err):
            state.error = err
        case .dismissError:
            state.error = nil
        }

        return state
    }
}

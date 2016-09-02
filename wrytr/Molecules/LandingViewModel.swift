import Cordux

extension Landing {
    struct ViewModel {
        var option: Option
        var loading: Bool
        var error: PresentableError?
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
    static var initialState: Landing.ViewModel {
        return Landing.ViewModel(option: .login, loading: false, error: nil)
    }
    
    static func reduce(state: Landing.ViewModel, action: Cordux.Action) -> Landing.ViewModel {
        guard let action = action as? Landing.Action else { return state }
        
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

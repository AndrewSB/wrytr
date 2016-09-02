import Cordux

extension Landing {
    struct ViewModel {
        enum Option {
            case login
            case register
        }
        
        var option: Option
        
        static var initialState: ViewModel {
            return ViewModel(option: .login)
        }
        
        static func reduce(state: ViewModel, action: Cordux.Action) -> ViewModel {
            guard let action = action as? Action else { return state }
            
            var state = state
            
            switch action {
            case .updateOption(let newOption):
                state.option = newOption
            }
            
            return state
        }
    }
    
    enum Action: Cordux.Action {
        case updateOption(ViewModel.Option)
    }
}

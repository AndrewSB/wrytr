import ReSwift

extension Landing {
    struct State: Equatable {
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

        static func == (lhs: State, rhs: State) -> Bool {
            return lhs.option == rhs.option
        }
    }

    enum Action: ReSwift.Action {
        case updateOption(State.Option)
        case dismissError
    }
}

extension Landing {

    static var reduce: Reducer<Landing.State> {
        return { action, state in
            var state = state ?? Landing.State()
            guard let landingAction = action as? Landing.Action else {
                return state
            }

            switch landingAction {
            case .updateOption(let newOption):
                state.option = newOption
            case .dismissError:
                break // the actual dismissal for this is handled outside of ReSwift, with a UIKit callback in LandingViewController
            }

            return state
        }
    }

}

import Cordux

extension Create {
    struct State {}

    enum Action: Cordux.Action {
        case post(text: String, user: UserType)
    }
}

extension Create {

    final class Reducer: Cordux.Reducer {
        public func handleAction(_ action: Cordux.Action, state: App.State) -> App.State {
            var state = state

            switch action {
            case let createAction as Create.Action:
                switch createAction {
                case Create.Action.post(let text, let user):
                    print("NEW POST: \(user): \(text)")
                }

            default:
                break
            }

            return state
        }
    }

}

import ReSwift

extension Authentication {
    enum State: ReSwift.StateType {
        case unauthenticated
        case authenticated
    }
    
    enum Action: ReSwift.Action {
        case signIn
        case signOut
    }

    class Reducer: Reducer {
        func handleAction(_ action: Action, state: State) -> State {
            return state
        }
    }
}

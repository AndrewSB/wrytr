import ReSwift
import Cordux

extension Authentication {
    enum State: ReSwift.StateType {
        case unauthenticated
        case authenticated
    }
    
    enum Action: ReSwift.Action {
        case signIn
        case signOut
    }
}

extension Authentication {
    class Reducer {
        typealias State = Authentication.State
        
        public func handleAction(_ action: Action, state: State) -> State {
            return state
        }
    }
}

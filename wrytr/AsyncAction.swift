import Cordux

typealias AsyncAction = ((_ state: Cordux.StateType, _ store: Store) -> Cordux.Action?)

extension Cordux.Store {
    func dispatch(_ actionCreatorProvider: @escaping (State, Cordux.Store<State>) -> Action?) {
        let action = actionCreatorProvider(state, self)

        if let action = action {
            dispatch(action)
        }
    }
}

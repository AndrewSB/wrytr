import Cordux

extension Cordux.Store {
    typealias AsyncAction = ((_ state: Cordux.StateType, _ store: Cordux.Store<State>) -> Cordux.Action?)

    func dispatch(_ actionCreatorProvider: @escaping AsyncAction) {
        let action = actionCreatorProvider(state, self)

        if let action = action {
            dispatch(action)
        }
    }
}

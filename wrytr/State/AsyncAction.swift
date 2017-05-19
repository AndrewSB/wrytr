import ReSwift

extension ReSwift.Store {
    typealias AsyncAction = ((_ state: StateType, _ store: Store<State>) -> Action?)

    func dispatch(_ actionCreatorProvider: @escaping AsyncAction) {
        let action = actionCreatorProvider(state, self)

        if let action = action {
            dispatch(action)
        }
    }
}

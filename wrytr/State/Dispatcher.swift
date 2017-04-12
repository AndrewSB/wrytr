import Cordux

/**
 A wrapper for a Cordux.store.dispatch
 */
class Dispatcher<State: Cordux.StateType> {
    private let store: Cordux.Store<State>

    init(store: Cordux.Store<State>) {
        self.store = store
    }

    func dispatch(_ action: Cordux.Action) {
        self.store.dispatch(action)
    }

    func dispatch(_ asyncActionCreator: @escaping Cordux.Store<State>.AsyncAction) {
        self.store.dispatch(asyncActionCreator)
    }
}

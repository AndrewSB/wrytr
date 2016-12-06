import Cordux

extension Create {
    struct State {}

    enum Action: Cordux.Action {}
}

extension Create {

    final class Reducer: Cordux.Reducer {
        typealias State = Create.State

        func handleAction(_ action: Action, state: Create.State) -> Create.State {
            return state
        }
    }

}

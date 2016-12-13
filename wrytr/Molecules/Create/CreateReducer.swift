import Cordux

extension Create {
    struct State {}

    enum Action: Cordux.Action {}
}

extension Create {

    final class Reducer: Cordux.Reducer {
        public func handleAction(_ action: Cordux.Action, state: App.State) -> App.State {
            return state
        }
    }

}

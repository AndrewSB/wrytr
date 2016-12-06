import Cordux

extension Me {
    class State {}

    enum Action: Cordux.Action {}
}

extension Me {
    final class Reducer: Cordux.Reducer {

        func handleAction(_ action: Cordux.Action, state: Me.State) -> Me.State {

            return state
        }

    }
}

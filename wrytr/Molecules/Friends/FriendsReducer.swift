import Cordux

extension Friends {
    class State {
        var challenge: Challenge.State = Challenge.State()
    }
}

extension Friends {
    final class Reducer: Cordux.Reducer {
        private let challengeReducer = Challenge.Reducer()

        func handleAction(_ action: Cordux.Action, state: App.State) -> App.State {
            state.friendsState.challenge = challengeReducer.handleAction(action, state: state.friendsState.challenge)

            return state
        }
    }
}

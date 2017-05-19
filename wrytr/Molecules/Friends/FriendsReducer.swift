import ReSwift

extension Friends {
    class State {
        var challenge: Challenge.State = Challenge.State()
    }
}

extension Friends {
    private lazy var challengeReducer = Challenge.Reducer()

    var reducer: Reducer {
        return { action, state in
            // TODO: try using a lens here
            var state = state
            state.friendsState.challenge = challengeReducer.handleAction(action, state: state.friendsState.challenge)

            return state
        }
    }
}

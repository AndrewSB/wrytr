import ReSwift

extension Friends {
    class State {
        var challenge: Challenge.State = Challenge.State()
    }
}

private lazy var challengeReducer = Challenge.reducer
extension Friends {
    var reducer: Reducer {
        return { action, state in
            // TODO: try using a lens here
            var state = state
            state.friendsState.challenge = challengeReducer(action, state: state.friendsState.challenge)

            return state
        }
    }
}

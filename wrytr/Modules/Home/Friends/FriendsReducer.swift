import ReSwift

extension Friends {
    class State {
        var challenge: Challenge.State = Challenge.State()
    }
}

extension Friends {
    static var reduce: Reducer<Friends.State> {
        return { action, state in
            return { (state) in
                state.challenge = Challenge.reduce(action, state.challenge)
                return state
            }(state ?? Friends.State())

/*
            var state = state ?? Friends.State()
            state.challenge = Challenge.reduce(action, state.challenge)

            return state
 */
        }
    }
}

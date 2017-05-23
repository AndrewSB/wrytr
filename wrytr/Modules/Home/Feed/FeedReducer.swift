import ReSwift

extension Feed {
    struct State {
        var challenge: Challenge.State = Challenge.State()
    }

    enum Action: ReSwift.Action {
        case dismissError
    }
}

extension Feed {

    static var reduce: Reducer<Feed.State> {
        return { action, state in
            var state = state ?? Feed.State()
            guard let feedAction = action as? Feed.Action else {
                return state
            }

            switch feedAction {
            case .dismissError:
                break // good to know. No state transition needed
            }

            state.challenge = Challenge.reduce(action, state.challenge)

            return state
        }
    }

}

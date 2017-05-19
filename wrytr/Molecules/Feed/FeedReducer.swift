import ReSwift

extension Feed {
    class State {
        var challenge: Challenge.State = Challenge.State()
        var error: PresentableError?
    }

    enum Action: Cordux.Action {
        case dismissError
    }
}

extension Feed {
    private lazy var challengeReducer = Challenge.Reducer()

    var reducer: Reducer {
        return { action, state in
            var state = state

            // TODO: refactor this. The abstraction of a Post.Action.errorLoadingPosts always pertaining to the feed is leaky
            switch action {
            case Post.LoadAction.errorLoadingPosts(let error):
                state.feedState.error = error

            case let feedAction as Feed.Action:
                switch feedAction {
                case .dismissError:
                    state.feedState.error = .none
                    state.postState.errorLoading = .none // TODO: this is part of the leaky abstraction. This is also repeated in the Friends Reducer :/
                }

            default:
                break
            }
            state.feedState.challenge = challengeReducer.handleAction(action, state: state.feedState.challenge)
            
            return state
        }
    }

}

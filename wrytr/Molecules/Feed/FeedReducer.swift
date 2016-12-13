import Cordux

extension Feed {
    class State {
        var challenge: Challenge.State = Challenge.State()
        var error: PresentableError? = nil
    }

    enum Action: Cordux.Action {
        case dismissError
    }
}

extension Feed {

    final class Reducer: Cordux.Reducer {
        private let challengeReducer = Challenge.Reducer()

        func handleAction(_ action: Cordux.Action, state: App.State) -> App.State {
            let state = state

            // TODO: refactor this. The abstraction of a Post.Action.errorLoadingPosts always pertaining to the feed is leaky
            switch action {
            case Post.Action.errorLoadingPosts(let error):
                state.feedState.error = error

            case let feedAction as Feed.Action:
                switch feedAction {
                case .dismissError:
                    state.feedState.error = nil
                }

            default:
                break
            }
            state.feedState.challenge = challengeReducer.handleAction(action, state: state.feedState.challenge)

            return state
        }

    }

}

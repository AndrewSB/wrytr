import ReSwift

extension Feed {
    class State {
        var challenge: Challenge.State = Challenge.State()
        var error: PresentableError?
    }

    enum Action: ReSwift.Action {
        case dismissError
    }
}

extension Feed {

    static var reduce: Reducer<Feed.State> {
        return { action, state in
            var state = state ?? Feed.State()

            // TODO: refactor this. The abstraction of a Post.Action.errorLoadingPosts always pertaining to the feed is leaky
            switch action {
            case Post.LoadAction.errorLoadingPosts(let error):
                state.error = error

            case let feedAction as Feed.Action:
                switch feedAction {
                case .dismissError:
                    state.error = .none

                    /*
                    state.postState.errorLoading = .none // TODO: this is part of the leaky abstraction. This is also repeated in the Friends Reducer :/
 
                    */
                    fatalError("uncomment above before continuing above")
                }

            default:
                break
            }
            state.challenge = Challenge.reduce(action, state.challenge)
            
            return state
        }
    }

}

import Cordux

extension Feed {
    class State {
        var postSource: Source = .friends
        var postOrdering: Ordering = .popular

        var error: PresentableError? = nil

        enum Source {
            case friends
            case everyone
        }

        enum Ordering {
            case new
            case popular
        }
    }

    enum Action: Cordux.Action {
        case dismissError
        case updateOrdering(State.Ordering)
        case updateSource(State.Source)
    }
}

extension Feed {

    final class Reducer: Cordux.Reducer {

        func handleAction(_ action: Cordux.Action, state: App.State) -> App.State {
            let state = state // TODO: why can this be a let? We're mutating this right below???

            // TODO: refactor this. The abstraction of a Post.Action.errorLoadingPosts always pertaining to the feed is leaky
            switch action {
            case Post.Action.errorLoadingPosts(let error):
                state.feedState.error = error

            case let feedAction as Feed.Action:
                switch feedAction {
                case .dismissError:
                    state.feedState.error = nil
                case .updateSource(let source):
                    state.feedState.postSource = source
                case .updateOrdering(let ordering):
                    state.feedState.postOrdering = ordering
                }

            default:
                break
            }

            return state
        }

    }

}

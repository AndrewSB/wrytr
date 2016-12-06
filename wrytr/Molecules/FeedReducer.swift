import Cordux

extension Feed {
    class State {
        var posts: [PostType] = []
        var error: PresentableError? = nil
    }

    enum Action: Cordux.Action {
        case dismissError
    }
}

extension Feed {

    final class Reducer: Cordux.Reducer {

        func handleAction(_ action: Cordux.Action, state: App.State) -> App.State {
            var state = state

            switch action {
            case let Post.Action.loaded(posts):
                state.feedState.posts = posts

            case let Post.Action.errorLoadingPosts(error):
                state.feedState.error = error

            case Feed.Action.dismissError:
                state.feedState.error = nil

            default:
                break
            }

            return state
        }

    }

}

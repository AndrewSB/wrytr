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

        func handleAction(_ action: Cordux.Action, state: Feed.State) -> Feed.State {
            let state = state

            switch action {
            case let Post.Action.loaded(posts):
                state.posts = posts

            case let Post.Action.errorLoadingPosts(error):
                state.error = error

            case Feed.Action.dismissError:
                state.error = nil

            default:
                break
            }

            return state
        }

    }

}

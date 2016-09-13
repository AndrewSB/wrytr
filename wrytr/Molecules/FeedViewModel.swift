import Cordux

extension Feed {
    struct ViewModel {
        var posts: [PostType] = []
        var error: PresentableError? = nil
    }

    enum Action: Cordux.Action {
        case dismissError
    }
}

extension Feed.ViewModel {

    final class Reducer: Cordux.Reducer {

        func handleAction(_ action: Cordux.Action, state: AppState) -> AppState {
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

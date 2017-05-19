import ReSwift

extension Create {
    struct State {
    }

    enum Action: Cordux.Action {
        case dismissError
    }
}

extension Create {

    var reducer: Reducer {
        return { action, state in
            var state = state

            // TODO: Potential limitation: Currently we can only create one post at a time
            switch action {
            case Post.CreateAction.createdPost(let post):
                state.route = ["home", "feed", post.id]

            case Action.dismissError:
                state.postState.errorCreating = .none

            default:
                break
            }

            return state
        }
    }

}

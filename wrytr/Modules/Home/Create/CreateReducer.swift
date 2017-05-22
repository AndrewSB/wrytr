import ReSwift

extension Create {
    struct State {
    }

    enum Action: ReSwift.Action {
        case dismissError
    }
}

extension Create {

    static var reduce: Reducer<Create.State> {
        return { action, state in
            var state = state ?? Create.State()

            // TODO: Potential limitation: Currently we can only create one post at a time
            switch action {
            case Action.dismissError:
                break // handled in Post.reduce

            default:
                break
            }

            return state
        }
    }

}

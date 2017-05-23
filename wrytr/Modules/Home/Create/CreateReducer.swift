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
            let state = state ?? Create.State()
            guard let createAction = action as? Create.Action else {
                return state
            }

            switch createAction {
            case .dismissError:
                break // handled in Post.reduce
            }

            return state
        }
    }

}

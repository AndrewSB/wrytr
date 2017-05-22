import ReSwift

extension Challenge {
    struct State {
        var postSource: Source = .friends
        var postOrdering: Ordering = .popular

        enum Source {
            case friends
            case everyone
        }

        enum Ordering {
            case new // swiftlint:disable:this variable_name
            case popular
        }
    }

    enum Action: ReSwift.Action {
        case updateOrdering(State.Ordering)
        case updateSource(State.Source)
    }
}

extension Challenge {
    static var reduce: Reducer<Challenge.State> {
        return { action, state in
            var state = state ?? Challenge.State()

            guard let challengeAction = action as? Challenge.Action else {
                return state
            }

            switch challengeAction {
            case .updateSource(let source):
                state.postSource = source
            case .updateOrdering(let ordering):
                state.postOrdering = ordering
            }

            return state
        }
    }
}

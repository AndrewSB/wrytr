import Cordux

extension Challenge {
    struct State {
        var postSource: Source = .friends
        var postOrdering: Ordering = .popular

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
        case updateOrdering(State.Ordering)
        case updateSource(State.Source)
    }
}

extension Challenge {
    final class Reducer: Cordux.Reducer {
        func handleAction(_ action: Cordux.Action, state: Challenge.State) -> Challenge.State {
            guard let challengeAction = action as? Challenge.Action else {
                return state
            }

            var state = state

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

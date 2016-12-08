import RxSwift
import Cordux

fileprivate let neverDisposeBag = DisposeBag()

extension Post {

    struct State {
        var posts: [PostType] = []

        // TODO: think about how this action should be structured? Should it be a queue of actions instead of just one?
        // this lets us express a loading & error state, but it's unfortunate that it can also hold a .loaded([PostType]) as well
        var lastAction: Action = .loaded([])
    }

    enum Action: Cordux.Action {
        case loadingPosts
        case loaded([PostType])
        case errorLoadingPosts(PresentableError)

        static func loadPosts() -> Cordux.Store<App.State>.AsyncAction {
            return { state, store in
                store.dispatch(Action.loadingPosts)

                Post.Service.getNewPosts().subscribe {
                    switch $0 {
                    case .next(let posts):
                        store.dispatch(Action.loaded(posts))
                    case .error(let err):
                        store.dispatch(Action.errorLoadingPosts(err as! PresentableError))
                    case .completed:
                        break
                    }
                }.addDisposableTo(neverDisposeBag)
                
                return nil
            }
        }
    }
}

extension Post {

    final class Reducer: Cordux.Reducer {
        func handleAction(_ action: Cordux.Action, state: App.State) -> App.State {
            var state = state

            switch action {
            case let postAction as Post.Action:
                switch postAction {
                case .loadingPosts:
                    state.postState.lastAction = postAction
                case .errorLoadingPosts:
                    state.postState.lastAction = postAction
                case .loaded(let posts):
                    state.postState.lastAction = postAction
                    state.postState.posts = posts // TODO: figure out how to resolve this. It should probably merge? Not replace the old posts
                }

            default:
                break
            }

            return state
        }
    }

}

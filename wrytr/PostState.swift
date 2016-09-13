import RxSwift
import Cordux

fileprivate let neverDisposeBag = DisposeBag()

extension Post {

    struct State {
        var posts: [PostType]
    }

    enum Action: Cordux.Action {
        case loadingPosts
        case loaded([PostType])
        case errorLoadingPosts(PresentableError)
    }

    static func loadPosts() -> AsyncAction {
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

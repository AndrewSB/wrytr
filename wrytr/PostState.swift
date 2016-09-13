import RxSwift
import Cordux

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
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                store.dispatch(Action.errorLoadingPosts(NSError(localizedDescription: "unimplemented", code: -1)))
            }

//            Post.Service.

            return nil
        }
    }
}

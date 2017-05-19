import RxSwift
import ReSwift

fileprivate let neverDisposeBag = DisposeBag()

extension Post {
    struct State {
        var loadedPosts: [PostType] = []
        var isLoadingPosts: Bool = false
        var errorLoading: PresentableError? = .none

        var createdPost: PostType? = .none
        var isCreatingPost: Bool = false
        var errorCreating: PresentableError? = .none
    }

    enum LoadAction: ReSwift.Action {
        case loadingPosts
        case loaded([PostType])
        case errorLoadingPosts(PresentableError)

        static func loadPosts() -> DefaultStore.AsyncAction {
            return { state, store in
                store.dispatch(LoadAction.loadingPosts)

                Post.Service.getNewPosts().subscribe {
                    switch $0 {
                    case .next(let posts):
                        store.dispatch(LoadAction.loaded(posts))
                    case .error(let err):
                        store.dispatch(LoadAction.errorLoadingPosts(err as PresentableError))
                    case .completed:
                        break
                    }
                }.addDisposableTo(neverDisposeBag)

                return nil
            }
        }
    }

    enum CreateAction: ReSwift.Action {
        case creatingPost(user: UserID, content: String)
        case createdPost(PostType)
        case errorCreatingPost(PresentableError)

        static func createPost(withContent content: String, by user: UserID) -> DefaultStore.AsyncAction {
            return { state, store in
                store.dispatch(CreateAction.creatingPost(user: user, content: content))

                Post.Service.createPost(prompt: content, by: user).subscribe {
                    switch $0 {
                    case .next(let post):
                        store.dispatch(CreateAction.createdPost(post))
                    case .error(let err):
                        store.dispatch(CreateAction.errorCreatingPost(err as PresentableError))
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
    static var reduce: Reducer<Post.State> {
        return { action, state in
            var state = state ?? Post.State()

            switch action {
            case let loadPostAction as Post.LoadAction:
                switch loadPostAction {
                case .loadingPosts:
                    state.errorLoading = .none
                    state.isLoadingPosts = true

                case .errorLoadingPosts(let err):
                    state.isLoadingPosts = false
                    state.errorLoading = err

                case .loaded(let posts):
                    state.isLoadingPosts = false
                    state.loadedPosts = posts // TODO: figure out how to resolve this. It should probably merge? Not replace the old posts
                }

            case let createPostAction as Post.CreateAction:
                switch createPostAction {
                case .creatingPost:
                    state.errorCreating = .none
                    state.isCreatingPost = true

                case .errorCreatingPost(let err):
                    state.isCreatingPost = false
                    state.errorCreating = err

                case .createdPost(let post):
                    state.isCreatingPost = false
                    state.createdPost = post
                }

            case Create.Action.dismissError:
                state.errorCreating = .none

            default:
                break
            }

            return state
        }
    }

}

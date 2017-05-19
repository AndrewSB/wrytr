import RxSwift

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

    enum LoadAction: Cordux.Action {
        case loadingPosts
        case loaded([PostType])
        case errorLoadingPosts(PresentableError)

        static func loadPosts() -> Cordux.Store<App.State>.AsyncAction {
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

    enum CreateAction: Cordux.Action {
        case creatingPost(user: UserID, content: String)
        case createdPost(PostType)
        case errorCreatingPost(PresentableError)

        static func createPost(withContent content: String, by user: UserID) -> Cordux.Store<App.State>.AsyncAction {
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

    final class Reducer: Cordux.Reducer {
        func handleAction(_ action: Cordux.Action, state: App.State) -> App.State {
            var state = state

            switch action {
            case let loadPostAction as Post.LoadAction:
                switch loadPostAction {
                case .loadingPosts:
                    state.postState.errorLoading = .none
                    state.postState.isLoadingPosts = true

                case .errorLoadingPosts(let err):
                    state.postState.isLoadingPosts = false
                    state.postState.errorLoading = err

                case .loaded(let posts):
                    state.postState.isLoadingPosts = false
                    state.postState.loadedPosts = posts // TODO: figure out how to resolve this. It should probably merge? Not replace the old posts
                }

            case let createPostAction as Post.CreateAction:
                switch createPostAction {
                case .creatingPost:
                    state.postState.errorCreating = .none
                    state.postState.isCreatingPost = true

                case .errorCreatingPost(let err):
                    state.postState.isCreatingPost = false
                    state.postState.errorCreating = err

                case .createdPost(let post):
                    state.postState.isCreatingPost = false
                    state.postState.createdPost = post
                }

            default:
                break
            }

            return state
        }
    }

}

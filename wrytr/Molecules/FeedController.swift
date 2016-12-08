import UIKit
import RxSwift
import RxCocoa
import Cordux

extension Feed {
    class Controller {
        private let disposeBag = DisposeBag()

        init(
            inputs: (
                pullToRefresh: ControlEvent<Void>,
                source: Observable<State.Source>,
                ordering: Observable<State.Ordering>
            ),
            sinks: (
                refreshControlVisible: UIBindingObserver<UIRefreshControl, Bool>,
                posts: Variable<[PostType]>
            ),
            store: StoreDependency = defaultStoreDependency
        ) {
            inputs.pullToRefresh.bindNext { store.dispatcher.dispatch(Post.Action.loadPosts()) }
                .addDisposableTo(disposeBag)

            inputs.ordering.map(Feed.Action.updateOrdering)
                .bindNext(store.dispatcher.dispatch)
                .addDisposableTo(disposeBag)

            inputs.source.map(Feed.Action.updateSource)
                .bindNext(store.dispatcher.dispatch)
                .addDisposableTo(disposeBag)

            store.state.asDriver()
                .map { $0.postState.lastAction }
                .map { lastAction in
                    switch lastAction {
                    case .loadingPosts:                 return true
                    case .errorLoadingPosts, .loaded:   return false
                    }
                }
                .drive(sinks.refreshControlVisible)
                .addDisposableTo(disposeBag)

            store.state.asDriver()
                .map { $0.postState.posts }
                .map { posts in
                    // TODO: use the source & ordering to mutate posts
                    return posts
                }
                .drive(sinks.posts)
                .addDisposableTo(disposeBag)

        }
    }

}

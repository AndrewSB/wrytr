import UIKit
import RxSwift
import RxCocoa

class Challenge {
    class Controller {
        private let disposeBag = DisposeBag()

        let output = (
            refreshControlVisible: Driver<Bool>(),
            posts: Variable<[PostType]>([])
        )

        init(
            inputs: (
                pullToRefresh: ControlEvent<Void>,
                source: Observable<State.Source>,
                ordering: Observable<State.Ordering>,
                challengeSelected: Observable<PostID>
            ),
            store: DefaultStore = App
        ) {

            inputs.pullToRefresh.map(Post.LoadAction.loadPosts)
                .bind(onNext: store.dispatcher.dispatch)
                .addDisposableTo(disposeBag)

            inputs.ordering.map(Challenge.Action.updateOrdering)
                .bind(onNext: store.dispatcher.dispatch)
                .addDisposableTo(disposeBag)

            inputs.source.map(Challenge.Action.updateSource)
                .bind(onNext: store.dispatcher.dispatch)
                .addDisposableTo(disposeBag)

            inputs.challengeSelected.map(RouteAction.push)
                .bind(onNext: store.dispatcher.dispatch)
                .addDisposableTo(disposeBag)

            store.state.asDriver()
                .map { $0.postState.isLoadingPosts }
                .drive(output.refreshControlVisible)
                .addDisposableTo(disposeBag)

            store.state.asDriver()
                .map { $0.postState.loadedPosts }
                .map { posts in
                    // TODO: use the source & ordering to mutate posts
                    return posts
                }
                .drive(sinks.posts)
                .addDisposableTo(disposeBag)

        }
    }

}

import UIKit
import ReSwift
import RxSwift
import RxCocoa

class Challenge {
    class Controller {
        private let disposeBag = DisposeBag()

        let output = (
            refreshControlVisible: Variable<Bool>(false),
            posts: Variable<[PostType]>([])
        )

        init(
            inputs: (
                pullToRefresh: ControlEvent<Void>,
                source: Variable<State.Source>,
                ordering: Observable<State.Ordering>,
                challengeSelected: Observable<PostType>
            ),
            challengeSelected: @escaping (PostType) -> (ReSwift.Action),
            store: DefaultStore = App.current.store
        ) {

            inputs.pullToRefresh.map(Post.LoadAction.loadPosts)
                .bind(onNext: store.dispatch)
                .addDisposableTo(disposeBag)

            inputs.ordering.map(Challenge.Action.updateOrdering)
                .bind(onNext: store.dispatch)
                .addDisposableTo(disposeBag)

            inputs.source.asDriver().map(Challenge.Action.updateSource)
                .drive(onNext: store.dispatch)
                .addDisposableTo(disposeBag)

            inputs.challengeSelected
                .map(challengeSelected)
                .bind(onNext: store.dispatch)
                .addDisposableTo(disposeBag)

            store.asDriver()
                .map { $0.postState.isLoadingPosts }
                .drive(output.refreshControlVisible)
                .addDisposableTo(disposeBag)

            store.asDriver()
                .map { $0.postState.loadedPosts }
                .map { posts in
                    // TODO: use the source & ordering to mutate posts
                    return posts
                }
                .drive(output.posts)
                .addDisposableTo(disposeBag)

        }
    }

}

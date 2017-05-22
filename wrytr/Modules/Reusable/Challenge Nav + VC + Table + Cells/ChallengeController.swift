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
                .map { challenge -> ReSwift.Action in
                    let homeRoute: (ChallengeRoute) -> HomeRoute = {
                        switch inputs.source.value {
                        case .friends:
                            return HomeRoute.friends
                        case .everyone:
                            return HomeRoute.feed
                        }
                    }()

                    guard store.state.route == .home(homeRoute(.table)) else { fatalError("programmer error") }
                    return Routing(to: .home(homeRoute(.detail(challenge))))
                }
                .bind(onNext: { action in
                    store.dispatch(action)
                })
                // .bind(onNext: store.dispatch)
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

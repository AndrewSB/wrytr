import RxSwift
import RxCocoa
import RxSwiftUtilities
import Cordux

extension Create {
    class Controller {
        private let disposeBag = DisposeBag()

        init(
            input: (
                text: Observable<String>,
                command: Observable<Void>
            ),
            store: StoreDependency = defaultStoreDependency
        ) {

            input.text
                .flatMapLatest(input.command.mapTo)
                .map {
                    Post.CreateAction.createPost(
                        withContent: $0,
                        by: store.state.value.authenticationState.user.userModelIfLoggedIn!.id
                     )
                }
                .subscribe(onNext: store.dispatcher.dispatch)
                .addDisposableTo(disposeBag)
        }
    }
}

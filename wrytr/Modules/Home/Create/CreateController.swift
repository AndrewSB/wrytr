import RxSwift
import RxCocoa
import RxSwiftUtilities

extension Create {
    class Controller {
        private let disposeBag = DisposeBag()

        init(
            input: (
                text: Observable<String>,
                command: Observable<Void>,
                dismissErrorTapped: Observable<Void>
            ),
            store: DefaultStore = App.current.store
        ) {

            input.text
                .map { postContent in
                    Post.CreateAction.createPost(withContent: postContent, by: store.state.authenticationState.user!.userModelIfLoggedIn!.id)
                }
                .flatMapLatest(input.command.mapTo)
                .subscribe(onNext: store.dispatch)
                .addDisposableTo(disposeBag)

            input.dismissErrorTapped.mapTo(Create.Action.dismissError)
                .subscribe(onNext: store.dispatch)
                .disposed(by: disposeBag)
        }
    }
}

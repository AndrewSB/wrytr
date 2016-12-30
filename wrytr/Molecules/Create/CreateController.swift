import RxSwift
import RxCocoa

extension Create {
    class Controller {
        private let disposeBag = DisposeBag()

        init(
            input: (
                text: ControlProperty<String>,
                command: ControlProperty<Void>
            ),
            store: StoreDependency = defaultStoreDependency
        ) {
        
        
            input.text
                .flatMapLatest { latestText in input.command.map { latestText} }
                .subscribe(onNext: handlePostingNewChallenge)
                .addDisposableTo(disposeBag)
        }
        
        private func handlePostingNewChallenge(challengeText: String) {
            
        }
    }
}

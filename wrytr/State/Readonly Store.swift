import Cordux
import RxCocoa

class ReadonlyStore<State: StateType> {
    private let store: Cordux.Store<State>

    init(store: Cordux.Store<State>) {
        self.store = store
    }

    var value: State {
        return self.store.state
    }

    func asDriver() -> Driver<State> {
        return self.store.asObservable().asDriver(onErrorJustReturn: self.value)
    }
}

import RxSwift
import Cordux

extension PostDetail {

    class UI: UIType {
        var loaderAndErrorPresenter: (ErrorPresentable & LoadingIndicatable)?

        let interface: ViewController.IB

        lazy var bindings: [Disposable] = []

        init(interface: ViewController.IB) {
            self.interface = interface
        }
    }

}

import UIKit
import RxSwift

extension Feed {
    class UI: UIType {
        weak var loaderAndErrorPresenter: (ErrorPresentable & LoadingIndicatable)?

        fileprivate let interface: ViewController.IB
        fileprivate let handler: Handler

        lazy var bindings: [Disposable] = []

        init(interface: ViewController.IB, handler: Handler) {
            self.interface = interface
            self.handler = handler
        }

    }
}

import UIKit
import RxSwift
import RxCocoa

extension Friends {
    class UI: UIType {
        weak var loaderAndErrorPresenter: (ErrorPresentable & LoadingIndicatable)?

        fileprivate let interface: Feed.ViewController.IB
        fileprivate let handler: Handler

        lazy var bindings: [Disposable] = []

        init(interface: Feed.ViewController.IB, handler: Handler) {
            self.interface = interface
            self.handler = handler
        }
    }
}

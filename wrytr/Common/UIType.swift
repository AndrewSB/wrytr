import UIKit
import RxSwift

protocol Primitive {}

protocol InterfaceProvidingPrimitive: class {
    var interface: Primitive! { get set }
}

class InterfaceProvidingViewController: UIViewController, InterfaceProvidingPrimitive {
    var interface: Primitive!
}

protocol UIType: class {
    weak var loaderAndErrorPresenter: LoadingIndicatable & ErrorPresentable? { get set }
    var bindings: [Disposable] { get set }
}

extension UIType {
    func showLoading() {
        self.loaderAndErrorPresenter?.startLoading()
    }

    func hideLoading() {
        self.loaderAndErrorPresenter?.stopLoading()
    }

    func presentError(error: PresentableError, actions: [UIAlertAction] = []) {
        self.loaderAndErrorPresenter?.presentError(error: error, actions: actions)
    }
}

import UIKit
import RxSwift

protocol Primitive {}

protocol InterfaceProvidingPrimitive: class {
    var interface: Primitive! { get set }
}

class InterfaceProvidingViewController: UIViewController, InterfaceProvidingPrimitive {
    var interface: Primitive!
}

protocol UIType {
    weak var viewController: UIViewController? { get set }
    var bindings: [Disposable] { mutating get set }
    
    func showLoading()
    func hideLoading()
    func presentError(error: PresentableError, actions: [UIAlertAction])
}

extension UIType {
    func showLoading() {
        self.viewController?.startLoading()
    }
    
    func hideLoading() {
        self.viewController?.stopLoading()
    }
    
    func presentError(error: PresentableError, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: error.title, message: error.description, preferredStyle: .alert)
        actions.forEach(alert.addAction)
        
        self.viewController?.present(alert, animated: true, completion: .none)
    }
}

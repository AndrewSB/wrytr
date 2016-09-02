import UIKit
import RxSwift

protocol Primitive {}

protocol InterfaceProvidingPrimitive {
    var interface: Primitive! { get set }
    var onViewDidLoad: (() -> ())? { get set }
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

/// Secretly holds things the viewController shouldn't be aware of, but have to be stored so they aren't dealloced. Look at Landing.swift for an example of how this is leveraged
class ForwardingViewController: UIViewController {
    fileprivate let disposeBag = DisposeBag()
    
    var ui: UIType? = nil {
        didSet {
            ui?.bindings.forEach(disposeBag.insert)
            ui?.viewController = self
        }
    }
    
    var handler: HandlerType?
}

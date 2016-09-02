import UIKit
import RxSwift

protocol Primitive {}

protocol InterfaceProvidingPrimitive {
    var interface: Primitive! { get set }
    var onViewDidLoad: (() -> ())? { get set }
}

protocol UIType {
    var bindings: [Disposable] { mutating get set }
}

/// Secretly holds things the viewController shouldn't be aware of, but have to be stored so they aren't dealloced. Look at Landing.swift for an example of how this is leveraged
class ForwardingViewController: UIViewController {
    fileprivate let disposeBag = DisposeBag()
    
    var ui: UIType? = nil {
        didSet {
            ui?.bindings.forEach(disposeBag.insert)
        }
    }
    
    var handler: HandlerType?
}

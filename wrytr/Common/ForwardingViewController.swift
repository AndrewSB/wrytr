import UIKit
import RxSwift

class ForwardingViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    var ui: UIType! = nil {
        didSet { ui.bindings.forEach(disposeBag.insert) }
    }

}

protocol UIType {
    var bindings: [Disposable] { mutating get set }
}

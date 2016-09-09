import UIKit
import RxSwift
import RxCocoa

extension Friends {
    class UI: UIType {
        weak var loaderAndErrorPresenter: (ErrorPresentable & LoadingIndicatable)?

        lazy var bindings: [Disposable] = []
    }
}

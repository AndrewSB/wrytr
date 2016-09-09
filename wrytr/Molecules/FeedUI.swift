import UIKit
import RxSwift

extension Feed {
    class UI: UIType {
        weak var loaderAndErrorPresenter: (ErrorPresentable & LoadingIndicatable)?

        lazy var bindings: [Disposable] = []
        
    }
}

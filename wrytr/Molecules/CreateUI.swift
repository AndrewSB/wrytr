import UIKit
import Cordux
import RxSwift
import PINRemoteImage

extension Create {
    class UI: UIType {
        weak var loaderAndErrorPresenter: (ErrorPresentable & LoadingIndicatable)?

        fileprivate let interface: ViewController.IB
        fileprivate let handler: Handler

        lazy var bindings: [Disposable] = []

        init(interface: ViewController.IB, handler: Handler) {
            self.interface = {
                let localUser = store.state.authenticationState.user!

                if let url = localUser.photo { $0.profile.pin_setImage(from: url) }
                $0.username.text = localUser.name

                return $0
            }(interface)

            self.handler = handler
        }
    }
}

extension Create.UI: Renderer {
    func render(_ viewModel: Create.ViewModel) {
        print(viewModel)
    }
}

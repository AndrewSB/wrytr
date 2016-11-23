import UIKit
import RxSwift
import Cordux
import Then

extension Feed {
    class UI: UIType {
        weak var loaderAndErrorPresenter: (ErrorPresentable & LoadingIndicatable)?

        fileprivate let interface: ViewController.IB
        fileprivate let handler: Handler

        lazy var bindings: [Disposable] = []

        init(interface: ViewController.IB, handler: Handler) {
            self.interface = {
                $0.tabBarItem.title = "dfsdfds"//tr(.feedTitle)

                return $0
            }(interface)
            self.handler = handler

            // dispatch async because we don't want to call dispatch to the store before currentScene is set in AppCoordinator, it causes an infinite loop
            DispatchQueue.main.async { self.handler.refreshPosts() }
        }

    }
}

extension Feed.UI: Renderer {
    func render(_ viewModel: Feed.ViewModel) {
        self.interface.tableView.posts.value = viewModel.posts
    }
}

import Cordux

class PostDetail {

    static func make(withRouteSegment routeSegment: RouteConvertible, store: Store) -> ForwardingViewController {
        let postDetailVC = ViewController.fromStoryboard()

        let uiCreationClosure = { (interface: Primitive) -> UIType in
            let interface = interface as! ViewController.IB

            return UI(interface: interface)
        }

        return ForwardingViewController(withViewController: postDetailVC, routeSegment: routeSegment, ui: uiCreationClosure)
    }

}

import Cordux

class Create {

    static func make(withRouteSegment routeSegment: RouteConvertible, store: Store) -> ForwardingViewController {
        let feedVC = ViewController.fromStoryboard()

        let uiCreationClosure = { (interface: Primitive) -> UIType in
            let interface = interface as! ViewController.IB
            let ui = UI(interface: interface, handler: Handler(store: store))
            ui.loaderAndErrorPresenter = feedVC
            //            store.subscribe(

            return ui
        }

        return ForwardingViewController(withViewController: feedVC, routeSegment: routeSegment, ui: uiCreationClosure)
    }


}

import Cordux

class Friends {

    static func make(withRouteSegment routeSegment: RouteConvertible, store: Store) -> ForwardingViewController {
        let feedVC = Feed.ViewController.fromStoryboard()

        let uiCreationClosure = { (interface: Primitive) -> UIType in
            let interface = interface as! Feed.ViewController.IB
            let ui = UI(interface: interface, handler: Handler(store: store))
            ui.loaderAndErrorPresenter = feedVC
            //            store.subscribe(

            return ui
        }

        return ForwardingViewController(withViewController: feedVC, routeSegment: routeSegment, ui: uiCreationClosure)
    }

}

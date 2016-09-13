import Cordux

class Feed {

    /**
     kocodude: I think my problem is I create these sub-objects that should in theory reduce complexity with SRP, but actually just explodes complexity...

     Would love your thoughts on this
     */
    static func make(withRouteSegment routeSegment: RouteConvertible, store: Store) -> ForwardingViewController {
        let feedVC = ViewController.fromStoryboard()

        let uiCreationClosure = { (interface: Primitive) -> UIType in
            let interface = interface as! ViewController.IB
            let ui = UI(interface: interface, handler: Handler(store: store))
            ui.loaderAndErrorPresenter = feedVC
            store.subscribe(ui, { $0.feedState })

            return ui
        }

        return ForwardingViewController(withViewController: feedVC, routeSegment: routeSegment, ui: uiCreationClosure)
    }

}

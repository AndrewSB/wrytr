import Cordux

class Landing {

    static func make(withRouteSegment routeSegment: RouteConvertible, store: Store) -> ForwardingViewController {
        let landingVC = ViewController.fromStoryboard()
        
        let uiCreationClosure = { (interface: Primitive) -> UIType in
            let interface = interface as! ViewController.IB
            let ui = UI(interface: interface, handler: Handler(store: store))
            ui.loaderAndErrorPresenter = landingVC
            store.subscribe(ui, { $0.landingState })
            
            return ui
        }
        
        return ForwardingViewController(withViewController: landingVC, routeSegment: routeSegment, ui: uiCreationClosure)
    }

}

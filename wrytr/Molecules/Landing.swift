import Cordux

class Landing {

    static func make(context: Context, store: Store) -> LandingViewController {
        let viewController = LandingViewController.fromStoryboard()
        viewController.corduxContext = context
        
        viewController.handler = Handler(store: store)
        
        viewController.onViewDidLoad = {
            viewController.ui = UI(
                interface: viewController.interface as! ViewController.IB,
                handler: viewController.handler as! Handler
            )
            store.subscribe(viewController.ui as! UI) { (appState: AppState) -> ViewModel in appState.landingState }
        }
    
        return viewController
    }

}

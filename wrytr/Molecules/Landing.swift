import Cordux

class Landing {

    static func make(context: Context) -> LandingViewController {
        let viewController = LandingViewController.fromStoryboard()
        viewController.corduxContext = context
    
        return viewController
    }

}

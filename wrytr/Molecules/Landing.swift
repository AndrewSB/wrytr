import Cordux

class Landing {

    static func build(context: Context) -> LandingViewController {
        let viewController = LandingViewController.fromStoryboard()
        viewController.corduxContext = context
    
        return viewController
    }

}

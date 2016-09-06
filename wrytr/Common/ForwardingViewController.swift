import UIKit
import RxSwift
import Cordux

/**
 An incredibly ugly class that makes it possible to use Cordux with modules.
 It holds onto the UI & Handler, without exposing either to the containedViewController.
 
 Here's an example:
    You'd like to create the Landing module, the only thing that can be held onto by the parent coordinator is 1 UIViewController, that is added to the parent's navigationController's stack. So you'd initialize a ForwardingViewController with:
        * a fresh LandingViewController
        * the routeSegment being created (.landing in this case)
        * a closure that takes in the view that just loaded (i.e. LandingViewController.view in this case), and creates the Landing.UI
    And then you'd add this new ForwardingViewController, that holds onto Module related things (UI & Handler), while leaving LandingViewController oblivous to the existance of the module.
 
    #gross but #lean
 */
class ForwardingViewController: UIViewController {
    fileprivate let disposeBag = DisposeBag()
    
    var ui: UIType? = nil {
        didSet {
            ui?.bindings.forEach(disposeBag.insert)
        }
    }
    
    var handler: HandlerType?
    
    let containedViewController: InterfaceProvidingViewController
    let onContainedViewDidLoad: ((Primitive) -> UIType)
    
    override var view: UIView! {
        get { return containedViewController.view }
        set { /*no-op*/ }
    }
    
    init(withViewController viewController: InterfaceProvidingViewController,
         routeSegment: RouteConvertible,
         ui: ((Primitive) -> UIType)) {
        self.containedViewController = viewController
        self.onContainedViewDidLoad = ui
        super.init(nibName: nil, bundle: nil)
        
        let context = Context(routeSegment, lifecycleDelegate: self)
        
        self.containedViewController.corduxContext = context
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension ForwardingViewController: ViewControllerLifecycleDelegate {
    func viewDidLoad(viewController: UIViewController) {
        switch viewController {
        case containedViewController:
            self.ui = onContainedViewDidLoad(containedViewController.interface)
        default:
            assertionFailure()
        }
    }
    
    func didMove(toParentViewController: UIViewController?, viewController: UIViewController) {
        assertionFailure("handle this somehow")
    }
}

import UIKit
import RxSwift
import ReSwift
import ReSwiftRouter
import Fabric
import Crashlytics
import TwitterKit
import FBSDKCoreKit
import Firebase

let firebase = Firebase(url: "http://wrytr.firebaseio.com")!

var store = Store<State>(reducer: AppReducer(), state: nil)

let neverDisposeBag = DisposeBag()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var router: Router<State>!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {

        Fabric.with([Crashlytics.self, Twitter.self])
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        /*
        Set a dummy VC to satisfy UIKit
        Router will set correct VC throug async call which means
        window would not have rootVC at completion of this method
        which causes a crash.
        */
        window?.rootViewController = UIViewController()
        
        let rootRoutable = RootRoutable(window: window!)
        router = Router(store: store, rootRoutable: rootRoutable) { state in
            state.navigationState
        }
        
        if case .loggedIn(_) = store.state.authenticationState.loggedInState {
            store.dispatch(ReSwiftRouter.SetRouteAction([mainRoute]))
        } else {
            store.dispatch(ReSwiftRouter.SetRouteAction([landingRoute]))
        }
        
        store.subscribe(self)
        
        window?.makeKeyAndVisible()
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
                
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }

}

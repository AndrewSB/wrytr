import UIKit
import Cordux

let store = Store(initialState: AppState(), reducer: appReducer, middlewares: [])

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator!

    private let thirdPartyServiceHandler = ThirdParty.Service.CombinedHandler([
        ThirdParty.Service.Facebook.Handler(),
        ThirdParty.Service.Fabric.Handler()
    ])

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        guard let mainController = window?.rootViewController as? StartupViewController else {
            fatalError()
        }

        UIViewController.swizzleLifecycleDelegatingViewControllerMethods()

        thirdPartyServiceHandler.onAppLaunch(application: application, launchOptions: launchOptions)

        coordinator = AppCoordinator(store: store, container: mainController)
        coordinator.start(route: store.state.route)

        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        thirdPartyServiceHandler.onAppActivate()
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return thirdPartyServiceHandler.onAppOpenURL(app: app, url: url, options: options)
    }

}

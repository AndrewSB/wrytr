import UIKit
import Cordux

extension App {

    @UIApplicationMain final class Delegate: UIResponder, UIApplicationDelegate {

        var window: UIWindow?
        var coordinator: App.Coordinator!

        private let thirdPartyServiceHandler = ThirdParty.Service.CombinedHandler([
            ThirdParty.Service.Facebook.Handler(),
            ThirdParty.Service.Fabric.Handler()
        ])

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
            guard let mainController = window?.rootViewController as? StartupViewController else {
                fatalError()
            }

            UITabBar.appearance().tintColor = Color(named: .tint)

            UIViewController.swizzleLifecycleDelegatingViewControllerMethods() // for cordux

            thirdPartyServiceHandler.onAppLaunch(application: application, launchOptions: launchOptions)

            coordinator = App.Coordinator(store: appStore, container: mainController)
            coordinator.start(route: appStore.state.route)

            return true
        }

        func applicationDidBecomeActive(_ application: UIApplication) {
            thirdPartyServiceHandler.onAppActivate()
        }

        func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
            return thirdPartyServiceHandler.onAppOpenURL(app: app, url: url, options: options)
        }

    }
}

import UIKit
import ReSwift

extension App {

    @UIApplicationMain final class Delegate: UIResponder, UIApplicationDelegate {

        var window: UIWindow?
        var app: App!

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {

            UITabBar.appearance().tintColor = Color(named: .tint)

            self.window =  UIWindow(frame: UIScreen.main.bounds).then { window in
                window.makeKeyAndVisible()
            }

            self.app = {
                let store = DefaultStore.create()
                let components = App.Components(
                    api: (User.Service.self, Post.Service.self),
                    router: Router(mainNavigation: RootNavigator(window: self.window!)),
                    thirdPartyServiceHandler: ThirdParty.Service.CombinedHandler([ThirdParty.Service.Facebook.Handler(), ThirdParty.Service.Fabric.Handler()])
                )

                let a = App(store: store, components: components)
                App.current = a
                return a
            }()

            self.app.components.thirdPartyServiceHandler.onAppLaunch(application: application, launchOptions: launchOptions)

            return true
        }

        func applicationDidBecomeActive(_ application: UIApplication) {
            self.app.components.thirdPartyServiceHandler.onAppActivate()
        }

        func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
            return self.app.components.thirdPartyServiceHandler.onAppOpenURL(app: app, url: url, options: options)
        }

    }
}

import UIKit
import ReSwift
import FacebookCore

typealias AppURLOpenParams = (UIApplication, URL, [UIApplicationOpenURLOptionsKey : Any])

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
                let a = App(store: DefaultStore.create(), components: App.Components.productionComponents(in: self.window!))
                App.current = a
                a.start()
                return a
            }()

            return true
        }

        func applicationDidBecomeActive(_ application: UIApplication) {
            self.app.onAppActivate()
        }

        func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
            return self.app.onAppOpenUrl(app, url, options)
        }

    }
}

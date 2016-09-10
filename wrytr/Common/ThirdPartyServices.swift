import UIKit

protocol ThirdPartyService {}

protocol ThirdPartyServiceHandler {
    func onAppLaunch(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey : Any]?)
    func onAppActivate()
    func onAppOpenURL(app: UIApplication, url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool
}


extension ThirdPartyServiceHandler {
    func onAppOpenURL(app: UIApplication, url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        return true
    }
}

class ThirdParty {
    class Service {
        class Handler: ThirdPartyServiceHandler {
            private let handlers: [ThirdPartyServiceHandler] = [Facebook.Handler(), Fabric.Handler()]

            func onAppLaunch(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey : Any]?) {
                handlers.forEach { $0.onAppLaunch(application: application, launchOptions: launchOptions) }
            }

            func onAppActivate() {
                handlers.forEach { $0.onAppActivate() }
            }

            func onAppOpenURL(app: UIApplication, url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
                return handlers
                    .map { $0.onAppOpenURL(app: app, url: url, options: options) }
                    .reduce(true) { accumulator, canOpenUrl in accumulator && canOpenUrl }
            }
        }
    }
}

import FBSDKCoreKit

extension ThirdParty.Service {
    class Facebook: ThirdPartyService {}
}

extension ThirdParty.Service.Facebook {
    class Handler: ThirdPartyServiceHandler {

        func onAppLaunch(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey : Any]?) {
            FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        }

        func onAppActivate() {
            FBSDKAppEvents.activateApp()
        }

        func onAppOpenURL(app: UIApplication, url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
            guard let sourceApp = options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String else {
                assertionFailure(); return false
            }
            let annotation = options[UIApplicationOpenURLOptionsKey.annotation]

            return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: sourceApp, annotation: annotation)
        }

    }
}

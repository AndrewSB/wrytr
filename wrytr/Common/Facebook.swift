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
    }
}

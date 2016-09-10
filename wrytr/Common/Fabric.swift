import Fabric
import TwitterKit
import Crashlytics

extension ThirdParty.Service {
    class Fabric: ThirdPartyService {

    }
}

extension ThirdParty.Service.Fabric {
    class Handler: ThirdPartyServiceHandler {
        func onAppLaunch(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey : Any]?) {
            Fabric.with([Crashlytics.self, Twitter.self])
        }

        func onAppActivate() {

        }
    }
}

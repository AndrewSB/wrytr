import Foundation
import UIKit.UIWindow
import FBSDKCoreKit.FBSDKApplicationDelegate
import Fabric
import Crashlytics
import TwitterKit

extension App {
    /// Application-level components, mostly services.
    struct Components {
        let api: (User.Service.Type, Post.Service.Type) // swiftlint:disable:this identifier_name
        let router: Router

        let facebook: (delegate: FBSDKApplicationDelegate, events: FBSDKAppEvents.Type)
        let fabric: Fabric
        let twitter: Twitter
    }

}

extension App.Components {
    static func productionComponents(in window: UIWindow) -> App.Components {
        return App.Components.init(
            api: (User.Service.self, Post.Service.self),
            router: Router(mainNavigation: RootNavigator(window: window)),
            facebook: (delegate: FBSDKApplicationDelegate.sharedInstance(), events: FBSDKAppEvents.self),
            fabric: Fabric.with([Crashlytics.self, Twitter.self]),
            twitter: Twitter.sharedInstance()
        )
    }
}

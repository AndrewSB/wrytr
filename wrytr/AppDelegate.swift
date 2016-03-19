//
//  AppDelegate.swift
//  wrytr
//
//  Created by Andrew Breckenridge on 3/4/16.
//  Copyright © 2016 Andrew Breckenridge. All rights reserved.
//

import UIKit

import ReSwift
import ReSwiftRouter

import Fabric
import Crashlytics

var store = Store<State>(reducer: AppReducer(), state: nil)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var router: Router<State>!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        Fabric.with([Crashlytics.self])
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
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
        
        if case .LoggedIn(_) = store.state.authenticationState.loggedInState {
            store.dispatch(ReSwiftRouter.SetRouteAction([mainRoute]))
        } else {
            store.dispatch(ReSwiftRouter.SetRouteAction([landingRoute]))
        }
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        
        return false
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


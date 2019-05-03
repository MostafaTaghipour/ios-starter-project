//
//  SuperAppDelegate.swift
//  Common
//
//  Created by Remote User on 9/17/18.
//  Copyright © 2018 hojan. All rights reserved.
//

import Foundation

@UIApplicationMain
open class SuperAppDelegate: UIResponder, UIApplicationDelegate {
    
    public var window: UIWindow?
    public var callViewControllerVisibilityMothodsOnAppVisibilityChange = false
    public var appDefaultOrientation = UIInterfaceOrientationMask.allButUpsideDown
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        appDidLaunch(application, launchOptions: launchOptions)
        
        return true
    }
    
    public func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return CurrentApp.topViewController?.orientation ?? appDefaultOrientation
    }
    
    
    /*
     Now your viewWillDisappear:, viewDidDisappear:, viewWillAppear: and viewDidAppear: methods of your view controller hierarchy will get called when you app goes to background and back to foreground
     */
    public func applicationDidEnterBackground(_ application: UIApplication) {
        if callViewControllerVisibilityMothodsOnAppVisibilityChange {
            for window in application.windows {
                window.rootViewController?.beginAppearanceTransition(false, animated: false)
                window.rootViewController?.endAppearanceTransition()
            }
        }
    }
    public func applicationWillEnterForeground(_ application: UIApplication) {
        if callViewControllerVisibilityMothodsOnAppVisibilityChange {
            for window in application.windows {
                window.rootViewController?.beginAppearanceTransition(true, animated: false)
                window.rootViewController?.endAppearanceTransition()
            }
        }
    }
    
    // custom methods
    open func appDidLaunch(_ application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {}
    
    open func appDidEnterBackground(_ application: UIApplication) {}
    open func appWillEnterForeground(_ application: UIApplication) {}
}

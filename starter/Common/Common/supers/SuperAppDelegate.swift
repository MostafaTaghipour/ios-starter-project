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
    
    
   
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        applicationDidLaunch(application, launchOptions: launchOptions)
        
        return true
    }
    
    
    public func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return CurrentApp.topViewController?.orientation ?? .allButUpsideDown
    }
    
    
    
    // custom methods
     open func applicationDidLaunch(_ application: UIApplication ,  launchOptions: [UIApplication.LaunchOptionsKey: Any]?){}
    
}



//
//  AppDelegate.swift
//  project
//
//  Created by Remote User on 10/28/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import UIKit
import  Common
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: SuperAppDelegate{

    var isConnectToInternet=false
    let assembler = AppAssembler(container: SwinjectStoryboard.defaultContainer)
    
    override func appDidLaunch(_ application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        initApp(application: application, launchOptions: launchOptions)
    }
    
    override func appDidEnterBackground(_ application: UIApplication) {
        // code here
    }
    
    override func appWillEnterForeground(_ application: UIApplication) {
         // code here
    }
}


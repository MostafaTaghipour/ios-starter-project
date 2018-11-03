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

    var isConnectToInternet=true
    let assembler = AppAssembler(container: SwinjectStoryboard.defaultContainer)
    
    override func applicationDidLaunch(_ application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        initApp(application: application, launchOptions: launchOptions)
    }
}


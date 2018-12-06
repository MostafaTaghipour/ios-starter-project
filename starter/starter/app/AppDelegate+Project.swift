//
//  AppDelegate+Project.swift
//  project
//
//  Created by Remote User on 10/28/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import mtpFontManager
import mtpThemeManager
import mtpLocaleManager
import RealmSwift
import SwinjectAutoregistration
import Common
import Firebase

extension AppDelegate{
    
    func initApp(application: UIApplication,launchOptions: [UIApplication.LaunchOptionsKey: Any]?){
        
        //IQKeyboardManager config
        IQKeyboardManager.shared.enable = true
        
        // Starts monitoring network reachability status changes
        ReachabilityManager.shared.startMonitoring { [weak self] (reachability) in
            self?.isConnectToInternet = reachability.connection != .none
        }

        //apply custom font and theme and locale
        FontManager.setFont(plist: R.file.appFontsPlist.name)
        ThemeManager.shared.setTheme(dayNight: RedTheme(), nightModeStatus: .disable)
        LocaleManager.shared.currentLocale = Locale(identifier: CurrentApp.developmentRegion!)
        
        //realm config
        var config = Realm.Configuration()
        config.schemaVersion=1
        let realmUrl = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(CurrentApp.baseBundleIdentifier).realm")
        config.fileURL=realmUrl
        Log.i("\n\trealm fileUrl:\n\t\(realmUrl)")
        //config.migrationBlock=RealmConfig.migrationBlock
        config.deleteRealmIfMigrationNeeded=true
        Realm.Configuration.defaultConfiguration = config
        
        //firebase config
        //by default project contains firebase crashlytics and analytics, if you want use it you must go to firebase console (https://console.firebase.google.com)
        //create your project , download and add GoogleService-Info.plist to project
        //todo: uncomment this line 
        //FirebaseApp.configure()
        
        //Hot Reload
        //InjectionApp is a Runtime Code Injection for Objective-C & Swift
        //If you want use it you must download injection app from (https://itunes.apple.com/us/app/injectioniii/id1380446739?ls=1&mt=12)
        //Run Injection app before run app on simulator
        //Select project directory if asked
        //todo: uncomment this line
        //HotReloader.activate()
        
        //start
        Navigator.start()
    }
    
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if handleDeeplinks(app, open: url, options: options){
            return true
        }
        
        return false
    }
    
    
    
    private func handleDeeplinks(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:])->Bool{
        
        let urlStr = url.absoluteString.lowercased()
        
        if urlStr.starts(with: AppConstants.deeplink_sample) {
             //todo: navigate to view controller
            return true
        }
        
        return false
    }
    
    
    
}

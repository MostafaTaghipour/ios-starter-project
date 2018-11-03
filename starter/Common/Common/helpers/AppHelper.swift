//  AppHelper.swift
//  common
//
//  Created by Remote User on 10/28/17.
//  Copyright © 2017 hojan. All rights reserved.
//


import Foundation



public var appDelegateInstance:SuperAppDelegate{
    get{
        
        let appDelegate=(UIApplication.shared.delegate as! SuperAppDelegate)
        return appDelegate
    }
}



public class CurrentApp{
    /// Return the main application bundle. If this is called from an extension, the containing app bundle is returned.
    public static var mainBundle: Bundle {
        let bundle = Bundle.main
        switch bundle.bundleURL.pathExtension {
        case "app":
            return bundle
        case "appex":
            // .../Client.app/PlugIns/SendTo.appex
            return Bundle(url: bundle.bundleURL.deletingLastPathComponent().deletingLastPathComponent())!
        default:
            fatalError("Unable to get application Bundle (Bundle.main.bundlePath=\(bundle.bundlePath))")
        }
    }
    
    public static var displayName: String? {
        return mainBundle.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
    
    public static var buildNumber: Int? {
        return (mainBundle.object(forInfoDictionaryKey:"CFBundleVersion") as? String)?.toInt()
    }
    
    public static var appVersion: String? {
        return mainBundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    public static var majorAppVersion: String? {
        return appVersion?.components(separatedBy: ".").first
    }
    
    public static var minorAppVersion: String? {
        return appVersion?.components(separatedBy: ".")[1]
    }
    
    public static var developmentRegion: String? {
        return mainBundle.object(forInfoDictionaryKey: "CFBundleDevelopmentRegion") as? String
    }
    
    /// Return the shared container identifier (also known as the app group) to be used with for example background
    /// http requests. It is the base bundle identifier with a "group." prefix.
    public static var sharedContainerIdentifier: String {
        var bundleIdentifier = baseBundleIdentifier
        if bundleIdentifier == "org.mozilla.ios.FennecEnterprise" {
            // Bug 1373726 - Base bundle identifier incorrectly generated for Nightly builds
            // This can be removed when we are able to fix the app group in the developer portal
            bundleIdentifier = "org.mozilla.ios.Fennec.enterprise"
        }
        return "group." + bundleIdentifier
    }
    
    /// Return the keychain access group.
    public static func keychainAccessGroupWithPrefix(_ prefix: String) -> String {
        var bundleIdentifier = baseBundleIdentifier
        if bundleIdentifier == "org.mozilla.ios.FennecEnterprise" {
            // Bug 1373726 - Base bundle identifier incorrectly generated for Nightly builds
            // This can be removed when we are able to fix the app group in the developer portal
            bundleIdentifier = "org.mozilla.ios.Fennec.enterprise"
        }
        return prefix + "." + bundleIdentifier
    }
    
    /// Return the base bundle identifier.
    ///
    /// This function is smart enough to find out if it is being called from an extension or the main application. In
    /// case of the former, it will chop off the extension identifier from the bundle since that is a suffix not part
    /// of the *base* bundle identifier.
    public static var baseBundleIdentifier: String {
        let bundle = Bundle.main
        let packageType = bundle.object(forInfoDictionaryKey: "CFBundlePackageType") as! String
        let baseBundleIdentifier = bundle.bundleIdentifier!
        if packageType == "XPC!" {
            let components = baseBundleIdentifier.components(separatedBy: ".")
            return components[0..<components.count-1].joined(separator: ".")
        }
        return baseBundleIdentifier
    }
    
    
    public static var topViewController : UIViewController? {
        return getTopViewController()
    }
    
    
    public class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            let moreNavigationController = tab.moreNavigationController
            
            if let top = moreNavigationController.topViewController, top.view.window != nil {
                return getTopViewController(base: top)
            } else if let selected = tab.selectedViewController {
                return getTopViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        
        return base
    }
    
    public class func getValueFromInfoPlist(key:String) -> String?{
        guard let info = mainBundle.infoDictionary else { return nil }
        return Plist(info)[key].string
    }
}





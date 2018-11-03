//
//  SuperRouter.swift
//  Common
//
//  Created by Remote User on 9/18/18.
//  Copyright © 2018 hojan. All rights reserved.
//

import UIKit

public protocol SuperRouterStatic{
    static var window:UIWindow? {get}
    static func restart()
    static func logout()
}

extension SuperRouterStatic{
    public static var window:UIWindow? {
        return appDelegateInstance.window
    }
    
    public static func restart(){
        guard
            let keyWindow = UIApplication.shared.keyWindow ,
            let storyboard = keyWindow.rootViewController?.storyboard ,
            let id = keyWindow.rootViewController?.value(forKey: "storyboardIdentifier") as? String  else {
                return
        }
        
        let rootVC = storyboard.instantiateViewController(withIdentifier: id)
        keyWindow.rootViewController = rootVC
    }
}



public protocol SuperRouter{
    var window:UIWindow? {get}
    func restart()
    func logout()
}

extension SuperRouter{
    public  var window:UIWindow? {
        return appDelegateInstance.window
    }
    
    public  func restart(){
        guard
            let keyWindow = UIApplication.shared.keyWindow ,
            let storyboard = keyWindow.rootViewController?.storyboard ,
            let id = keyWindow.rootViewController?.value(forKey: "storyboardIdentifier") as? String  else {
                return
        }
        
        let rootVC = storyboard.instantiateViewController(withIdentifier: id)
        keyWindow.rootViewController = rootVC
    }
}

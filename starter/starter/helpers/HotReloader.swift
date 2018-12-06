//
//  HotReloader.swift
//  starter
//
//  Created by Mostafa Taghipour on 12/5/18.
//  Copyright © 2018 hojan. All rights reserved.
//

import UIKit

class HotReloader{
    static fileprivate  var isActive = false
    static func activate(){
        isActive = true
        
        #if DEBUG
        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection10.bundle")?.load()
        #endif
    }
}




extension UIViewController {
    
    #if DEBUG
    @objc func injected() {
        guard HotReloader.isActive else {
            return
        }
        
        for subview in self.view.subviews {
            subview.removeFromSuperview()
        }
        if let sublayers = self.view.layer.sublayers {
            for sublayer in sublayers {
                sublayer.removeFromSuperlayer()
            }
        }
        
        loadView()
        viewDidLoad()
    }
    #endif
}


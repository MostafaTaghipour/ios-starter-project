//
//  BaseViewController.swift
//  Sample
//
//  Created by Mostafa Taghipour on 5/2/19.
//  Copyright © 2019 hojan. All rights reserved.
//

import UIKit
import mtpFontManager
import SwiftEventBus
import Common
import LifetimeTracker

class BaseViewController : SuperViewController   {
    
    var trackLifeTime : Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardOnTap=false
        StyleWatcher().watchViews(inView: self.view)
        setBackButton(title: " ", icon: nil)
        onReady()
        if self.trackLifeTime{
            trackLifetime()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onPreAppear()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        onAppeared()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dismissKeyboard()
        onPreDisappear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onDisappeared()
    }
    
    override func willRotate(to orientation: UIDeviceOrientation) {
        dismissKeyboard()
    }
    
    
    //MARK:- Life cycle
    func onReady(){}
    func onPreAppear(){}
    func onAppeared(){}
    func onPreDisappear(){}
    func onDisappeared(){}
}



extension BaseViewController:  LifetimeTrackable  {
    static var lifetimeConfiguration : LifetimeConfiguration {
        return LifetimeConfiguration(maxCount: 1, groupName: AppConstants.lifetimeTrackableViewControllerGroupName)
    }
}


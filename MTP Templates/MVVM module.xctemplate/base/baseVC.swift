//  
//  BaseViewController.swift
//  MyProject
//
//  Created by Remote User on 10/28/18.
//  Copyright © 2018 hojan. All rights reserved.
//

import UIKit
import mtpFontManager
import SwiftEventBus
import Common
import LifetimeTracker

class BaseViewController: SuperViewController   {
    
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
        subscribeEvents()
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
        unsubscribeEvents()
        onDisappeared()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        on_view_ready()
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
    func on_view_ready(){}
    


    //MARK:- Events
    private func subscribeEvents(){
        SwiftEventBus.onMainThread(self, name: BusEvents.message.rawValue) {[weak self](notification) in
            guard let event = notification?.object as? MessageEvent else { return  }

            self?.onMessageEvent(event: event)
        }
        SwiftEventBus.onMainThread(self, name: BusEvents.navigation.rawValue) {[weak self] (notification) in
            guard let event = notification?.object as? NavigationEvent else { return  }

            self?.onNavigationEvent(event: event)
        }
        SwiftEventBus.onMainThread(self, name: BusEvents.httpError.rawValue) {[weak self] (notification) in
            guard let error = notification?.object as? HttpError else { return  }
            self?.onHttpError(httpError: error)
        }
        SwiftEventBus.onMainThread(self, name: BusEvents.dismiss.rawValue) { [weak self] (notification) in
            self?.onDismissEvent()
        }

        SwiftEventBus.onMainThread(self, name: BusEvents.noInternetAccess.rawValue) { [weak self] (notification) in
            self?.onLostInternetConnection()
        }
    }

    private func unsubscribeEvents(){
        SwiftEventBus.unregister(self, name:BusEvents.message.rawValue)
        SwiftEventBus.unregister(self, name: BusEvents.navigation.rawValue)
        SwiftEventBus.unregister(self, name:  BusEvents.httpError.rawValue)
        SwiftEventBus.unregister(self, name:BusEvents.noInternetAccess.rawValue)
        SwiftEventBus.unregister(self, name:BusEvents.dismiss.rawValue)
    }

    open func onNavigationEvent(event:NavigationEvent){
//        if event.destination is AuthVC.Type{
//            Navigator.logout()
//        }
        //todo
    }

    open func onDismissEvent(){
        dismissCompatible()
    }

    open func onMessageEvent(event:MessageEvent){
        event.show()
    }

    open func onHttpError(httpError:HttpError){
        errorMessage(body: httpError.localizedDescription)
    }

    private func onLostInternetConnection(){
        statusMessage(title: R.string.errors.error_internet_connection(), style: .error)
    }
}



extension BaseViewController:  LifetimeTrackable  {
    static var lifetimeConfiguration : LifetimeConfiguration {
        return LifetimeConfiguration(maxCount: 1, groupName: AppConstants.lifetimeTrackableViewControllerGroupName)
    }
}

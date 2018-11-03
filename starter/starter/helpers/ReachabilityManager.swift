//
//  ReachabilityManager.swift
//  Footkal
//
//  Created by Remote User on 4/19/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import UIKit
import Reachability // 1. Importing the Library

class ReachabilityManager: NSObject {
    
    typealias ReachabilityListener = ((Reachability)->Void)
    var listener:ReachabilityListener?
    
     // 2. Shared instance
    static  let shared = ReachabilityManager()
    
    // 3. Boolean to track network reachability
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .none
    }
    
    // 4. Tracks current NetworkStatus (notReachable, reachableViaWiFi, reachableViaWWAN)
    var reachabilityStatus: Reachability.Connection = .none
    
    // 5. Reachability instance for Network status monitoring
    let reachability = Reachability()!
    
    
    /// Called whenever there is a change in NetworkReachibility Status
    ///
    /// — parameter notification: Notification with the Reachability instance
    @objc func reachabilityChanged(notification: Notification) {
        let reachability = notification.object as! Reachability
        listener?(reachability)
        
//        switch reachability.connection {
//        case .none:
//            debugPrint("Network became unreachable")
//            AppDelegateInstance.isConnectToInternet=false
//        case .wifi:
//            debugPrint("Network reachable through WiFi")
//             AppDelegateInstance.isConnectToInternet=true
//        case .cellular:
//            debugPrint("Network reachable through Cellular Data")
//             AppDelegateInstance.isConnectToInternet=true
//        }
    }
    
    /// Starts monitoring the network availability status
    func startMonitoring(listener:@escaping ReachabilityListener) {
        self.listener=listener
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: Notification.Name.reachabilityChanged,
                                               object: reachability)
        do{
            try reachability.startNotifier()
        } catch {
            debugPrint("Could not start reachability notifier")
        }
    }
    
    /// Stops monitoring the network availability status
    func stopMonitoring(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name.reachabilityChanged,
                                                  object: reachability)
    }
}

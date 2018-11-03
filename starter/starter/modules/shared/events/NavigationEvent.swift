//
//  NavigationEvent.swift
//  project
//
//  Created by Remote User on 10/29/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import UIKit

class NavigationEvent:BusEvent {
    var destination:UIViewController.Type
    var params:[String:AnyObject]?=nil
    
    init(  destination:UIViewController.Type,
           params:[String:AnyObject]?=nil) {
        self.destination=destination
        self.params=params
    }
}



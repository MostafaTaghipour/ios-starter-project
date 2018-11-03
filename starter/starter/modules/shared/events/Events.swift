//
//  Events.swift
//  pharmacy
//
//  Created by Remote User on 1/20/18.
//  Copyright © 2018 hojan. All rights reserved.
//

import Foundation

enum BusEvents:String {
    case message = "message"
    case dismiss = "dismiss"
    case httpError = "httpError"
    case navigation = "navigation"
    case noInternetAccess = "noInternetAccess"
}

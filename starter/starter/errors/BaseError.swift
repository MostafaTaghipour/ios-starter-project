//
//  BaseError.swift
//  project
//
//  Created by Remote User on 10/31/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import Foundation

//MARK:- General FootkalError
protocol BaseError: Swift.Error {
    var localizedDescription:String{get}
}



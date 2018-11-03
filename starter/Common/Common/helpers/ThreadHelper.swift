//
//  ThreadHelper.swift
//  common
//
//  Created by Remote User on 12/12/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import Foundation

public func delay(_ delay: Double, block: @escaping () -> ()) {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        block()
    }
}

public func delayBackground(_ delay: Double, block: @escaping () -> ()) {
    
   DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + delay) {
        block()
    }
}

public func backgroundThread(_ block: @escaping () -> ()){
    DispatchQueue.global(qos: .background).async {
        block()
    }
}


public func uiThread(_ block: @escaping () -> ()){
    DispatchQueue.main.async {
        block()
    }
}

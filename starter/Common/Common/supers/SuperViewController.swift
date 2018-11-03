//
//  SuperViewController.swift
//  Common
//
//  Created by Remote User on 9/18/18.
//  Copyright © 2018 hojan. All rights reserved.
//

import Foundation

open class SuperViewController : UIViewController  {
    
   open func willRotate(to orientation:UIDeviceOrientation){}
   open func didRotate(in orientation:UIDeviceOrientation){}
    
    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
   
        willRotate(to: CurrentDevice.orientation)
    
        coordinator.animate(alongsideTransition: nil, completion: {
            _ in
            
            self.didRotate(in: CurrentDevice.orientation)
        })
    }
    
}

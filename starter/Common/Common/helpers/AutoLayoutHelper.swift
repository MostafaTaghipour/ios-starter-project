//
//  AutoLayoutHelper.swift
//  common
//
//  Created by Remote User on 11/28/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import UIKit

extension UIView {
    

   public func matchBoundsToParent() {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `matchBoundsToParent()` to fix this.")
            return
        }
        
        edgeToEdge( toView: superview)
    }
    
    public func cenetrInParent() {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `cenetrInParent()` to fix this.")
            return
        }
        
        centerToCenter( toView: superview)
    }
    
    
    public func edgeToEdge(toView:UIView) {
        translatesAutoresizingMaskIntoConstraints = false
       leadingAnchor.constraint(equalTo: toView.leadingAnchor).isActive = true
       trailingAnchor.constraint(equalTo: toView.trailingAnchor).isActive = true
       bottomAnchor.constraint(equalTo: toView.bottomAnchor).isActive = true
       topAnchor.constraint(equalTo: toView.topAnchor).isActive = true
    }
    
    public func centerToCenter(toView:UIView) {
        translatesAutoresizingMaskIntoConstraints = false
      centerXAnchor.constraint(equalTo: toView.centerXAnchor).isActive = true
       centerYAnchor.constraint(equalTo: toView.centerYAnchor).isActive = true
    }
}

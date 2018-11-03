//
//  AnimationHelper.swift
//  common
//
//  Created by Remote User on 10/31/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import UIKit


//MARK:- Shake
public enum ShakeDirection : Int {
    case Horizontal = 0
    case Vertical = 1
}

/*
 Swift Framework creation: http://bit.ly/1T8SkUR
 Build your own Cocoa Touch Frameworks, in pure Swift: http://bit.ly/1gNLyZ8
 Deleting contents from Xcode Derived data folder: http://bit.ly/1ItWqSo
 */
extension UIView {

   public func shake(times: Int=10, withDelta delta: CGFloat=5, speed interval: TimeInterval = 0.03, shakeDirection: ShakeDirection=ShakeDirection.Horizontal, completion: (() -> Void)? = nil) {
        _shake(times: times, direction: 1, currentTimes: 0, withDelta: delta, speed: interval, shakeDirection: shakeDirection, completion: completion)
    }
    
    
    private func _shake( times: Int,
                         direction: Int,
                         currentTimes current: Int,
                         withDelta delta: CGFloat,
                         speed interval: TimeInterval ,
                         shakeDirection: ShakeDirection,
                         completion handler: (() -> Void)?) {
        
        
        
        UIView.animate(withDuration: interval, animations: {
            () -> Void in
            self.transform = (shakeDirection == ShakeDirection.Horizontal) ?
                CGAffineTransform(translationX: delta * CGFloat(direction), y: 0) :
                CGAffineTransform(translationX: 0, y: delta * CGFloat(direction))
        }, completion: {
            ( finished: Bool) in
            if current >= times {
                UIView.animate(withDuration: interval, animations: {
                    () -> Void in
                    self.transform = .identity
                }, completion: {
                    ( finished: Bool) in
                    if let handler = handler {
                        handler()
                    }
                })
                return
            }
            self._shake(times: times - 1,
                        direction: direction * -1,
                        currentTimes: current + 1,
                        withDelta: delta,
                        speed: interval,
                        shakeDirection: shakeDirection,
                        completion: handler)
        })
    }
    
}


//MARK:- Fade
extension UIView {
   public func fadeIn(withDuration duration: TimeInterval=0.2, completion: ((Bool) -> Swift.Void)? = nil){
        UIView.animate(withDuration: duration, animations: {
            self.alpha=1.0
        }, completion: completion)
    }
    
   public func fadeOut(withDuration duration: TimeInterval=0.2, completion: ((Bool) -> Swift.Void)? = nil){
        UIView.animate(withDuration: duration, animations: {
            self.alpha=0.0
        }, completion: completion)
    }
}


//
//  KeyboardHelper.swift
//  common
//
//  Created by Remote User on 11/23/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import UIKit

public protocol KeyboardVisibilityDelegate:class {
    //MARK:- keyboard Observer
    func keyboardWillShow(notification:Notification)
    func keyboardDidShow(notification:Notification)
    func keyboardWillHide(notification:Notification)
    func keyboardDidHide(notification:Notification)
}

extension KeyboardVisibilityDelegate{
  public  func keyboardWillShow(notification:Notification){}
   public func keyboardDidShow(notification:Notification){}
   public func keyboardWillHide(notification:Notification){}
    public func keyboardDidHide(notification:Notification){}
}

public class KeyboardHelper {
    
    
 public private (set) var isKeyboardVisible:Bool=false
  public private (set) var keyboardFrame:CGRect?
    
    private weak var  keyboardDelegate:KeyboardVisibilityDelegate?
    
    public init() {
        
    }
    
    deinit {
        removeKeyboardObserver()
    } 
}

//MARK:- Keyboard show/hide
extension KeyboardHelper{
   public class func showKeyboard(responder:UIResponder){
        responder.becomeFirstResponder()
    }
   public class func dismissKeyboard(viewController:UIViewController?=nil){
        if let vc=viewController{
            vc.view.endEditing(true)
        }
        else{
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        }
    }
}


//MARK:- Keyboard visibility change
extension KeyboardHelper{
   public func addKeyboardObserver(keyboardDelegate:KeyboardVisibilityDelegate) {
        self.keyboardDelegate = keyboardDelegate
        
        NotificationCenter.default.setObserver(self,
                                               selector: #selector(self.keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.setObserver(self,
                                               selector: #selector(self.keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        NotificationCenter.default.setObserver(self,
                                               selector: #selector(self.keyboardDidShow),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        NotificationCenter.default.setObserver(self,
                                               selector: #selector(self.keyboardDidHide),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
    }
    
   public func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    
    
    @objc func keyboardWillShow(notification:Notification){
        keyboardDelegate?.keyboardWillShow(notification: notification)
    }
    @objc func keyboardDidShow(notification:Notification){
        isKeyboardVisible=true
        keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        keyboardDelegate?.keyboardDidShow(notification: notification)
    }
    @objc  func keyboardWillHide(notification:Notification){
        keyboardDelegate?.keyboardWillHide(notification: notification)
    }
    @objc  func keyboardDidHide(notification:Notification){
        isKeyboardVisible=false
        keyboardFrame = .zero
        keyboardDelegate?.keyboardDidHide(notification: notification)
    }
}


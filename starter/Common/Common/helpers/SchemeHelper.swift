//  SchemeHelper.swift
//  common
//
//  Created by Remote User on 4/18/18.
//  Copyright © 2018 hojan. All rights reserved.
//

import Foundation
import UIKit




public func canOpen(url:String)->Bool{
    guard let url = URL(string: url) else {
        return false
    }
    return UIApplication.shared.canOpenURL(url)
}


public func open(url:String){
    guard canOpen(url: url),let url = URL(string: url) else {
        return //be safe
    }
    
    if #available(iOS 10.0, *) {
        UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    } else {
        UIApplication.shared.openURL(url)
    }
}

public func sms(to:String?,body:String?){
    if let url = "sms:\(to ?? "_")&body=\(body ?? "")".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
        open(url: url)
    }
}



public func call(to:String,prompt: Bool=true){
    let url = "\(prompt ? "telprompt" : "tel")://\(to)"
    open(url: url)
}



public func email(to:String? ,subject:String?,body:String?){
    if let url = "mailto:\(to ?? "")?subject=\(subject ?? "")&body=\(body ?? "")".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
        open(url: url)
    }
}


public func telegram(to:String? ,body:String?){
    if let url = "tg://msg?text=\(body ?? "")&to=\(to ?? "")".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
        open(url: url)
    }
}

public func whatsapp(to:String? ,body:String?){
    if let url = "whatsapp://send?abid=\(to ?? "")&text=\(body ?? "")".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
        open(url: url)
    }
}

public func twitter(body:String){
    if let url = "twitter://post?message=\(body)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
        open(url: url)
    }
}

public func share(viewController:UIViewController,sourceView:UIView,objectsToShare:AnyObject...){
    let activityViewController = UIActivityViewController(activityItems : objectsToShare, applicationActivities: nil)
    
    if let popoverController =  activityViewController.popoverPresentationController {
        popoverController.sourceView = sourceView
        popoverController.sourceRect = sourceView.bounds
    }
    
    viewController.present(activityViewController, animated: true, completion: nil)
}





// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}

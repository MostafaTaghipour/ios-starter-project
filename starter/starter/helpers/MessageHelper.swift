//
//  MessageHelper.swift
//  project
//
//  Created by Remote User on 10/30/17.
//  Copyright © 2017 hojan. All rights reserved.
//
import UIKit
import Firebase
import Crashlytics
import SwiftMessages

enum Duration :TimeInterval{
    case short=2
    case long=4
}

enum MessegeStyle:Int{
    case regular=0
    case info=1
    case error=2
    case warning=3
    case success=4
}




/// log error in firebase by crashlytics
///
/// - Parameters:
///   - error: happened error
///   - withAdditionalUserInfo: if you want log additional data
func logError(error:Error,withAdditionalUserInfo:[String:Any]? = nil){
    Crashlytics.sharedInstance().recordError(error, withAdditionalUserInfo: withAdditionalUserInfo)
}


/// log events in firebase by analytics
///
/// - Parameters:
///   - name: name of event
///   - parameters: additional parameters
func logEvent(name:String,parameters: [String:Any]? = nil){
    Analytics.logEvent(name,parameters: parameters)
}

func message(_ title:String? = nil,
             body:String? = nil,
             iconImage:UIImage?=nil,
             backgroundColor:UIColor? = nil,
             foregroundColor:UIColor? = nil,
             buttonTitle:String?=nil,
             buttonBackgroundColor:UIColor? = nil,
             buttonForegroundColor:UIColor? = nil,
             shadow:Bool=true,
             overlay:Bool=false,
             interactive:Bool=true,
             style: MessageView.Layout = .centeredView ,
             theme:Theme = .info,
             position:SwiftMessages.PresentationStyle = .center,
             presentationContext:SwiftMessages.PresentationContext = .automatic,
             preferredStatusBarStyle : UIStatusBarStyle = .default,
             buttonTapHandler: ((_ button: UIButton) -> Void)? = nil){
    
    // message style conatins: messageView , cardView , tabView , statusLine , centeredView , messageViewIOS8
    let view = MessageView.viewFromNib(layout: style)
    
    
    // Theme message conatins:  info , success , warning , error
    view.configureTheme(theme, iconStyle: .light)
    if let bg=backgroundColor , let fg=foregroundColor{
        view.configureTheme(backgroundColor: bg, foregroundColor: fg)
    }
    
    // Add a drop shadow.
    if shadow{
        view.configureDropShadow()
    }
    
    
    //config message content
    view.configureContent(title: title, body: body, iconImage:iconImage, iconText: nil, buttonImage:  nil, buttonTitle: buttonTitle, buttonTapHandler: buttonTapHandler)
    
    
    //button config
    if buttonTitle==nil{
        view.button?.isHidden=true
    }
    if let color=buttonBackgroundColor{
        view.button?.backgroundColor=color
    }
    if let color=buttonForegroundColor{
        view.button?.tintColor=color
    }
    view.button?.titleLabel?.font = UIFont.systemFont(ofSize: view.button!.titleLabel!.fontSize)
    
    
    //text styling
    view.titleLabel?.font = UIFont.boldSystemFont(ofSize: view.titleLabel!.fontSize)
    view.bodyLabel?.font = UIFont.systemFont(ofSize:  view.bodyLabel!.fontSize)
    
    var config = SwiftMessages.Config()
    
    // presentationStyle contain: tope , center , bottom
    config.presentationStyle = position
    
    // background overlay
    if overlay{
        config.dimMode = .gray(interactive: interactive)
    }
    
    // interactive status
    config.interactiveHide = interactive
    
    //status bar style
    config.preferredStatusBarStyle = preferredStatusBarStyle
    
    
    // Display in a window at the specified window level: UIWindowLevelStatusBar
    // displays over the status bar while UIWindowLevelNormal displays under.
    config.presentationContext = presentationContext
    
    // Show the message.
    SwiftMessages.show(config: config, view: view)
}

func dismissMessage(){
    SwiftMessages.hide()
}

func dismissAllMessages(){
    SwiftMessages.hideAll()
}


func snack(_ msg:String,buttonTitle: String?=nil,buttonForegroundColor: UIColor?=nil,buttonTapHandler: ((_ button: UIButton) -> Void)? = nil){
    message( body: msg,  backgroundColor: UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0), foregroundColor: .white, buttonTitle: buttonTitle, buttonBackgroundColor: .clear, buttonForegroundColor: buttonForegroundColor,  style: .messageView,  position: .bottom, buttonTapHandler: buttonTapHandler)
}

func styledMessage(_ title:String?=nil,body:String,style:MessegeStyle = .regular,topAll:Bool=false){
    
    var backgroundColor:UIColor!
    
    switch style {
    case .error:
        backgroundColor = .error
        break
    case .warning:
        backgroundColor = .warning
        break
    case .success:
        backgroundColor = .success
        break
    case .info:
        backgroundColor = .info
        break
    case .regular:
        backgroundColor = .darkGray
        break
    }
    
    message(title,
            body: body,
            backgroundColor:backgroundColor,
            foregroundColor: .white,
            style: .centeredView,
            position: .top,
            presentationContext: topAll ? .window(windowLevel: UIWindow.Level.statusBar) : .automatic,
            preferredStatusBarStyle  : .lightContent)
}


func errorMessage(_ title:String?=nil,body:String,topAll:Bool=false){
    styledMessage(title,body: body, style: .error,topAll: topAll)
}

func infoMessage(_ title:String?=nil,body:String,topAll:Bool=false){
    styledMessage(title,body: body, style: .info,topAll: topAll)
}

func successMessage(_ title:String?=nil,body:String,topAll:Bool=false){
    styledMessage(title,body: body, style: .success,topAll: topAll)
}

func warningMessage(_ title:String?=nil,body:String,topAll:Bool=false){
    styledMessage(title,body: body, style: .warning,topAll: topAll)
}


func statusMessage(title:String?,style:MessegeStyle = .regular){
    
    var backgroundColor:UIColor!
    
    switch style {
    case .error:
        backgroundColor = .error
        break
    case .warning:
        backgroundColor = .warning
        break
    case .success:
        backgroundColor = .success
        break
    case .info:
        backgroundColor = .info
        break
    case .regular:
        backgroundColor = .darkGray
        break
    }
    
    message( body: title,  backgroundColor:backgroundColor,foregroundColor: .white, style: .statusLine,  position: .top , presentationContext: .window(windowLevel: UIWindow.Level.statusBar))
}

func customMessage(view:UIView){
    SwiftMessages.show(view: view)
}





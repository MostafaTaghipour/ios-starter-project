//
//  SecureUserDefaultRepo.swift
//  pharmacy
//
//  Created by Remote User on 10/1/18.
//  Copyright © 2018 hojan. All rights reserved.
//

import Foundation
import SecureNSUserDefaults


protocol CredentionalRepo {
    var accessToken:String? {get set}
    var notificationClientId:String? {get set}
    var expires:String? {get set}
    var tokenExpired:Bool {get set}
    var isSessionValid:Bool {get}
    func sync()
    func clear()
}

class SecureUserDefaultsRepo : CredentionalRepo{
 
    private let expire_key = "expire_token"
    private let token_key = "access_token"
    private let notification_client_id_key = "notification_client_id"
    private let default_string = ""
    private let secretKey="Pharmacy_iOS_client"
    
    
    private var userDefault:UserDefaults
    
    private init(userDefault:UserDefaults) {
        self.userDefault=userDefault
        self.userDefault.setSecret(secretKey)
        
        //        let defaultValues: [String:Any] = [:]
        //        userDefault.register(defaults: defaultValues)
        
        load()
        
    }
    
    
    
    private var _accessToken:String?
    var accessToken:String?{
        get{
            return _accessToken
        }
        set{
            _accessToken=newValue
        }
    }
    
    
    private var _notificationClientId:String?
    var notificationClientId:String?{
        get{
            return _notificationClientId
        }
        set{
            _notificationClientId=newValue
        }
    }
    
    
    private var _expires:String?
    var expires:String?{
        get{
            return _expires
        }
        set{
            _expires=newValue
        }
    }
    
    
    
    var tokenExpired:Bool{
        get{
            if let expired = _expires?.asDateISO8601()?.isPast{
                return expired
            }
            return true
        }
    }
    
    
    var isSessionValid:Bool{
        get{
            return _accessToken.isNotNilAndEmpty && !tokenExpired
        }
    }
    
  
    private func load() {
        self.accessToken=userDefault.secretString(forKey: token_key)
        self.expires=userDefault.secretString(forKey: expire_key)
        self.notificationClientId=userDefault.secretString(forKey: notification_client_id_key)
    }
    
    
    func sync() {
        
        if let token = accessToken{
            userDefault.setSecretObject(token, forKey: token_key)
        }
        
        if let expires = expires{
            userDefault.setSecretObject(expires, forKey: expire_key)
        }
        
        if let notifId = notificationClientId{
            userDefault.setSecretObject(notifId, forKey: notification_client_id_key)
        }
        
        userDefault.synchronize()
    }
    
    
    
    func clear() {
        expires=default_string
        accessToken=default_string
        notificationClientId=default_string
        sync()
    }
    
}


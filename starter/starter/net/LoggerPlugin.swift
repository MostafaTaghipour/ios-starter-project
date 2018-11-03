//
//  LoggerPlugin.swift
//  project
//
//  Created by Remote User on 11/1/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import Foundation
import Result
import Moya
import Common


/// Logs network activity (outgoing requests and incoming responses).
public final class NetworkLoggerPlugin: PluginType {
    fileprivate let dateFormatString = StandardDateFormat.iso8601DateTimeMillis.rawValue
    fileprivate let dateFormatter = DateFormatter()
    fileprivate let newLine = "\n"
    fileprivate let tab = "\t"
    fileprivate let terminator = "\n\n"
    
    public func willSend(_ request: RequestType, target: TargetType) {
        logRequest(request.request as URLRequest?)
    }
    
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        if case .success(let response) = result {
            logResponse(response.response, data: response.data, target: target)
        } else {
            logResponse(nil, data: nil, target: target)
        }
    }
    
    var date: String {
        dateFormatter.dateFormat = dateFormatString
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: Date())
    }
    
    
    
    func logRequest(_ request: URLRequest?){
        
        
        guard self.debugMode , let request=request else {
            return
        }
        
        
        
        var output = newLine
        output += newLine
        output += newLine
        output += "========================== BEGIN REQUEST =========================="
        
        output += terminator
        output += "DATE: \(date)"
        
        
        if let url = request.url{
            output += terminator
            output += "URL: \(url)"
        }
        
        if let method = request.httpMethod{
            output += terminator
            output += "METHOD: \(method)"
        }
        
        if let headers = request.allHTTPHeaderFields {
            output += terminator
            output += "HEADERS:"
            output += newLine
            output += JSONStringify(value: headers as AnyObject, prettyPrinted: true)
        }
        
        
        if let data = request.httpBody ,  let json = try?  JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]  {
            output += terminator
            output += "BODY:"
            output += newLine
            output +=  JSONStringify(value: json as AnyObject, prettyPrinted: true)
        }
        else if let data = request.httpBody ,  let json = try?  JSONSerialization.jsonObject(with: data, options: []) as? [Any]  {
            output += terminator
            output += "BODY:"
            output += newLine
            output +=  JSONStringify(value: json as AnyObject, prettyPrinted: true)
        }
        
        output += newLine
        output += newLine
        output += "=========================== END REQUEST ==========================="
        output += newLine
        output += newLine
        output += newLine
        
        print(output)
        
        
    }
    
    func logResponse(_ response: URLResponse?, data: Data?, target: TargetType){
        
        
        if !self.debugMode{
            return
        }
        
        guard let response = response  else {
            print("Received empty network response for \(target) at [\(date)].")
            return
        }
        
        var output = newLine
        output += newLine
        output += newLine
        output += "========================= BEGIN RESPONSE =========================="
        
        
        output += terminator
        output += "DATE: \(date)"
        
        
        if let url = response.url{
            output += terminator
            output += "URL: \(url)"
        }
        
        
        if let response = response as? HTTPURLResponse{
            output += terminator
            output += "STATUS: \(response.statusCode)"
            
            
            let headers = response.allHeaderFields
            output += terminator
            output += "HEADERS:"
            output += newLine
            output += JSONStringify(value: headers as AnyObject, prettyPrinted: true)
        }
        
        if let data = data,  let json:[String: Any] = (try?  JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] , !json.isEmpty {
            output += terminator
            output += "BODY:"
            output += newLine
            output +=  JSONStringify(value: json as AnyObject, prettyPrinted: true)
        }
        else if let data = data,  let json: [Any] = (try?  JSONSerialization.jsonObject(with: data, options: [])) as? [Any] , !json.isEmpty {
            output += terminator
            output += "BODY:"
            output += newLine
            output +=  JSONStringify(value: json as AnyObject, prettyPrinted: true)
        }
     
        
        output += newLine
        output += newLine
        output += "========================== END RESPONSE ==========================="
        output += newLine
        output += newLine
        output += newLine
        
        print(output)
    }
    
    
    
  private  var debugMode:Bool
    {
        var res=false
        
        #if DEBUG
            res=true
        #else
            res=false
        #endif
        
        return res
    }
    
   private func JSONStringify(value: AnyObject, prettyPrinted: Bool = true) -> String {
        let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : nil
        if JSONSerialization.isValidJSONObject(value) {
            do {
                let data = try JSONSerialization.data(withJSONObject: value, options: options!)
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            }  catch {
                return ""
            }
        }
        return ""
    }
}







//
//  HttpErrorBody.swift
//  project
//
//  Created by Remote User on 10/7/18.
//  Copyright © 2018 hojan. All rights reserved.
//

import Foundation


struct HttpErrorBody: Codable {
    
    let developerMessage : String
    let errorCode : Double
    let moreInfo : String?
    let userMessage : String
    
    
    enum CodingKeys : String, CodingKey
    {
        case developerMessage = "DeveloperMessage"
        case errorCode = "ErrorCode"
        case moreInfo = "MoreInfo"
        case userMessage = "UserMessage"
    }
    
}

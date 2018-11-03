//
//  AlamofireSessionManager.swift
//  project
//
//  Created by Remote User on 11/4/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import Foundation
import Alamofire

//set request default timeout
class AlamofireSessionManager: Alamofire.SessionManager {
    static let sharedManager: AlamofireSessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = WebApi.time_out// as seconds, you can set your request timeout
        configuration.timeoutIntervalForResource = WebApi.time_out // as seconds, you can set your resource timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return AlamofireSessionManager(configuration: configuration)
    }()
}

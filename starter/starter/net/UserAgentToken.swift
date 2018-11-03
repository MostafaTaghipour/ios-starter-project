//
//  UserAgentToken.swift
//  project
//
//  Created by Remote User on 11/5/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import Foundation
import Moya

struct UserAgentPlugin: PluginType {
    let userAgent: String
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        request.addValue(userAgent, forHTTPHeaderField: "User-Agent")
        return request
    }
}

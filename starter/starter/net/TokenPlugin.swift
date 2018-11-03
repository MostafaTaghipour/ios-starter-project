//
//  TokenPlugin.swift
//  project
//
//  Created by Remote User on 11/1/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import Foundation
import Moya
import SwinjectAutoregistration


struct TokenPlugin: PluginType {

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        let credentionalsRepo : CredentionalsRepo? = injectOptional()
        let token = credentionalsRepo?.accessToken ?? "***** not set *****"
        request.addValue("Bearer " + token , forHTTPHeaderField: "Authorization")
        return request
    }
}








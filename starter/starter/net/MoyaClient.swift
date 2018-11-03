//
//  MoyaClient.swift
//  project
//
//  Created by Remote User on 11/1/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Alamofire

class WebApi {
    static var baseUrl: String {
        switch BuildConfig.type {
        case .development:
            return "https://url.dev"
        case .staging:
            return "https://url.stage"
        case .production:
            return "https://url.com"
        }
    }
    
    public static let time_out : TimeInterval = 40
}

extension TargetType{
    var baseURL: URL { return URL(string: WebApi.baseUrl)! }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}




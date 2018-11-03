//
//  Moya+.swift
//  project
//
//  Created by Remote User on 11/5/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import Foundation
import Moya


extension MoyaError{
    var statusCode:HttpStatusCode?
    {
        if case MoyaError.statusCode(let response) = self {
            return HttpStatusCode(rawValue: response.statusCode)
        }
        return nil
    }
}


extension Moya.Response{
    var body:String?{
        return String(data: self.data, encoding: .utf8)
            //.replacingOccurrences(of: "\"", with: "")
    }
}


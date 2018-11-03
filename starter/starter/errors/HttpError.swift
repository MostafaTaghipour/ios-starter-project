//
//  File.swift
//  project
//
//  Created by Remote User on 10/31/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import Foundation

class HttpError:BaseError{
    var statusCode:HttpStatusCode?
    var errorBody:HttpErrorBody?
    
    var localizedDescription: String{
        return errorBody?.userMessage ?? R.string.errors.error_http_regular()
    }
}


struct UnauthorizedError:BaseError {
    
}

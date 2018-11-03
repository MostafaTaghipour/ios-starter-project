//
//  OrderEntities.swift
//  project
//
//  Created by Remote User on 3/7/18.
//  Copyright © 2018 hojan. All rights reserved.
//

import Foundation
import RealmSwift

struct SampleJson: Codable {
    
    let id : Int64
    let title : String
    
    enum CodingKeys : String, CodingKey
    {
        case id = "Id"
        case title = "Title"
    }
}



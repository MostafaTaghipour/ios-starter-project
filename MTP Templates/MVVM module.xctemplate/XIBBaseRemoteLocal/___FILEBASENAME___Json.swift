//  ___FILEHEADER___

import Foundation
import RealmSwift

struct ___FILEBASENAMEASIDENTIFIER___ : Codable {
    
    let id : Int64
    let title : String
    
    enum CodingKeys : String, CodingKey
    {
        case id = "Id"
        case title = "Title"
    }
}



//
//	AddressRealmObject.swift
//
//	Create by Remote User on 24/12/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import RealmSwift


class SampleEntity: Object {
    
    @objc dynamic var id: Int64 = 0
    @objc dynamic var title: String!

    override class func primaryKey() -> String? {
        return "id"
    }
}







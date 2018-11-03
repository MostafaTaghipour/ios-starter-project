//
//  RealmDataSource.swift
//  pharmacy
//
//  Created by Remote User on 3/3/18.
//  Copyright © 2018 hojan. All rights reserved.
//

import Foundation
import RealmSwift

class BooksRealmDataSource<Type:Object>: BaseDataSource {

    typealias T = Type
    
    private let realm = try! Realm()
    
    func getAll() -> Results<Type> {
        return realm.objects(Type.self)
    }
    
    func insert(item: Type,replaceIfConflict:Bool = true) {
        try! realm.write {
            realm.add(item, update: replaceIfConflict)
        }
    }
    
    func update(item: Type) {
        
    }
    
    func upsert(item: Type) {
        
    }
    
    func clean() {
        try! realm.write {
            realm.delete(realm.objects(Type.self))
        }
    }
    
    func deleteById(id: String) {
        let object = getById(id)
        try! realm.write {
            realm.delete(object)
        }
    }
}

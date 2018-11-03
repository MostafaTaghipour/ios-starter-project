//  ___FILEHEADER___

import Foundation
import RealmSwift

open class BaseRealmDataSource<Type:Object> {
    
    let realm = try! Realm()
    
    func get(predicate:NSPredicate? = nil) -> Results<Type> {
        var res =  realm.objects(Type.self)
        if let filter = predicate {
            res=res.filter(filter)
        }
        return res
    }
    
    func upsert(_ item: Type,replaceIfConflict:Bool = true) {
        try? realm.safeWrite {
            realm.add(item, update: replaceIfConflict)
        }
    }
    
    func upsert<S: Sequence>(_ items: S,replaceIfConflict:Bool = true) where S.Iterator.Element==Type {
        try? realm.safeWrite {
            realm.add(items, update: replaceIfConflict)
        }
    }
    
    func delete(_ item: Type) {
        try? realm.safeWrite {
            realm.delete(item)
        }
    }
    
    func delete<S: Sequence>(_ items: S) where S.Iterator.Element==Type {
        try? realm.safeWrite {
            realm.delete(items)
        }
    }
    
    func delete(predicate:NSPredicate) {
       let items = get(predicate: predicate)
            try? realm.safeWrite {
                realm.delete(items)
            }
        
    }
    
    func clean() {
        try? realm.safeWrite {
            realm.delete(realm.objects(Type.self))
        }
    }
}


extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}

//  ___FILEHEADER___

import Foundation
import RealmSwift



class ___FILEBASENAMEASIDENTIFIER___Imp:BaseRealmDataSource<___VARIABLE_productName:identifier___Entity> , ___FILEBASENAMEASIDENTIFIER___{
    
    private let ID_KEY="id"
    
    func getAll() -> Results<___VARIABLE_productName:identifier___Entity> {
        return get()
    }
    
    func get(id: Int64)->Results<___VARIABLE_productName:identifier___Entity>{
        return super.get(predicate: NSPredicate(format: "\(ID_KEY) = %d", id))
    }
    
    func delete(id: Int64) {
        super.delete(predicate: NSPredicate(format: "\(ID_KEY) = %d", id))
    }
}




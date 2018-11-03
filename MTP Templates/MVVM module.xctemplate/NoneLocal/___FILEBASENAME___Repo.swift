//  ___FILEHEADER___

import Foundation
import RealmSwift
import RxSwift
import RxRealm

class ___FILEBASENAMEASIDENTIFIER___Imp : ___FILEBASENAMEASIDENTIFIER___{
    
    private var dataSource : ___VARIABLE_productName:identifier___DataSource!
    
    init(dataSource:___VARIABLE_productName:identifier___DataSource) {
        self.dataSource = dataSource
    }
    
    
    func getFromDB() -> Results<___VARIABLE_productName:identifier___Entity> {
        return dataSource.getAll()
    }
    
    func getFromDB(id:Int64) -> ___VARIABLE_productName:identifier___Entity? {
    return  dataSource.get(id: id).first
    }
    
    func getFromDBLive() -> Observable<[___VARIABLE_productName:identifier___Entity]> {
        return Observable
            .array(from: dataSource.getAll())
    }
    
    func upsertIntoDB(item: ___VARIABLE_productName:identifier___Entity){
        self.dataSource.upsert(item)
    }
    
    func upsertIntoDB(items: [___VARIABLE_productName:identifier___Entity]){
        self.dataSource.upsert(items)
    }
    
    func deleteFromDB(id:Int64){
        self.dataSource.delete(id: id)
    }
    
}



//  ___FILEHEADER___

import Foundation
import RealmSwift
import RxSwift
import RxRealm
import Moya


class ___FILEBASENAMEASIDENTIFIER___Imp : ___FILEBASENAMEASIDENTIFIER___{
    private var apiProvider:ApiProvider<___VARIABLE_productName:identifier___Api>!
    private var dataSource : ___VARIABLE_productName:identifier___DataSource!
    
    init(apiProvider:ApiProvider<___VARIABLE_productName:identifier___Api>,dataSource:___VARIABLE_productName:identifier___DataSource) {
        self.apiProvider = apiProvider
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
    
    func getFromServer()-> Single<[___VARIABLE_productName:identifier___Json]> {
        return self.apiProvider.request(.getAll, responseType: [___VARIABLE_productName:identifier___Json].self)
    }
    
    
    func getFromServer(id:Int64)-> Single<___VARIABLE_productName:identifier___Json> {
        return self.apiProvider.request(.get(id:id), responseType: ___VARIABLE_productName:identifier___Json.self)
    }
    
    func upsertIntoDB(item: ___VARIABLE_productName:identifier___Entity){
        self.dataSource.upsert(item)
    }
    
    func upsertIntoDB(items: [___VARIABLE_productName:identifier___Entity]){
        self.dataSource.upsert(items)
    }
    
    func insertIntoServer(item: ___VARIABLE_productName:identifier___Json) -> Single<Response>{
        return self.apiProvider.request(.insert(body: item))
    }
    
    func deleteFromDB(id:Int64){
        self.dataSource.delete(id: id)
    }
    
    func deleteFromServer(id:Int64) -> Single<Response>{
        return self.apiProvider.request(.delete(id: id))
    }
}



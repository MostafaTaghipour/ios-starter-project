//  ___FILEHEADER___

import Foundation
import RealmSwift
import RxSwift
import Moya

// repository
protocol ___VARIABLE_productName:identifier___Repo {
    func getFromDB() -> Results<___VARIABLE_productName:identifier___Entity>
    func getFromDB(id:Int64) -> ___VARIABLE_productName:identifier___Entity?
    func getFromDBLive() -> Observable<[___VARIABLE_productName:identifier___Entity]>
    func getFromServer()-> Single<[___VARIABLE_productName:identifier___Json]>
    func getFromServer(id:Int64)-> Single<___VARIABLE_productName:identifier___Json>
    func upsertIntoDB(item: ___VARIABLE_productName:identifier___Entity)
    func upsertIntoDB(items: [___VARIABLE_productName:identifier___Entity])
    func insertIntoServer(item: ___VARIABLE_productName:identifier___Json) -> Single<Response>
    func deleteFromDB(id:Int64)
    func deleteFromServer(id:Int64) -> Single<Response>
}

// local data source
protocol ___VARIABLE_productName:identifier___DataSource {
    func getAll()->Results<___VARIABLE_productName:identifier___Entity>
    func get(id: Int64)->Results<___VARIABLE_productName:identifier___Entity>
    func upsert(_ item: ___VARIABLE_productName:identifier___Entity,replaceIfConflict:Bool)
    func upsert(_ items: [___VARIABLE_productName:identifier___Entity],replaceIfConflict:Bool)
    func delete(id:Int64)
    func clean()
}

extension ___VARIABLE_productName:identifier___DataSource {
    func upsert(_ item: ___VARIABLE_productName:identifier___Entity){
        upsert(item, replaceIfConflict: true)
    }
    func upsert(_ items: [___VARIABLE_productName:identifier___Entity]){
        upsert(items, replaceIfConflict: true)
    }
}


// web api
enum ___VARIABLE_productName:identifier___Api {
    case getAll()
    case get(id: Int64)
    case delete(id: Int64)
    case insert(body: ___VARIABLE_productName:identifier___Json)
    case update(id: Int64,body: ___VARIABLE_productName:identifier___Json)
    case upload(image: UIImage, id: Int64)
}



// view model
protocol ___VARIABLE_productName:identifier___ViewModel {
    var text : Variable<String?> {get}
    func doSomething()
}


//  ___FILEHEADER___

import Foundation
import RealmSwift
import RxSwift

// repository
protocol ___VARIABLE_productName:identifier___Repo {
    func getFromDB() -> Results<___VARIABLE_productName:identifier___Entity>
    func getFromDB(id:Int64) -> ___VARIABLE_productName:identifier___Entity?
    func getFromDBLive() -> Observable<[___VARIABLE_productName:identifier___Entity]>
    func upsertIntoDB(item: ___VARIABLE_productName:identifier___Entity)
    func upsertIntoDB(items: [___VARIABLE_productName:identifier___Entity])
    func deleteFromDB(id:Int64)
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

// view model
protocol ___VARIABLE_productName:identifier___ViewModel {
    var text : Variable<String?> {get}
    func doSomething()
}

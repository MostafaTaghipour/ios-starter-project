//  ___FILEHEADER___

import Foundation
import RxSwift
import Moya

// repository
protocol ___VARIABLE_productName:identifier___Repo {
    func getFromServer()-> Single<[___VARIABLE_productName:identifier___Json]>
    func getFromServer(id:Int64)-> Single<___VARIABLE_productName:identifier___Json>
    func insertIntoServer(item: ___VARIABLE_productName:identifier___Json) -> Single<Response>
    func deleteFromServer(id:Int64) -> Single<Response>
}


// web api
enum ___VARIABLE_productName:identifier___Api {
    case getAll
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


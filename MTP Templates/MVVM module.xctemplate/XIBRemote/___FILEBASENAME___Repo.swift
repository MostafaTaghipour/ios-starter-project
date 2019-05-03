//  ___FILEHEADER___

import Foundation
import RxSwift
import Moya

class ___FILEBASENAMEASIDENTIFIER___Imp : ___FILEBASENAMEASIDENTIFIER___{
    private var apiProvider:ApiProvider<___VARIABLE_productName:identifier___Api>!
    
    init(apiProvider:ApiProvider<___VARIABLE_productName:identifier___Api>) {
        self.apiProvider = apiProvider
    }
    
    
    func getFromServer()-> Single<[___VARIABLE_productName:identifier___Json]> {
        return self.apiProvider.request(.getAll, responseType: [___VARIABLE_productName:identifier___Json].self)
    }
    
    
    func getFromServer(id:Int64)-> Single<___VARIABLE_productName:identifier___Json> {
        return self.apiProvider.request(.get(id:id), responseType: ___VARIABLE_productName:identifier___Json.self)
    }
    
    func insertIntoServer(item: ___VARIABLE_productName:identifier___Json) -> Single<Response>{
        return self.apiProvider.request(.insert(body: item))
    }
    
    func deleteFromServer(id:Int64) -> Single<Response>{
        return self.apiProvider.request(.delete(id: id))
    }
}



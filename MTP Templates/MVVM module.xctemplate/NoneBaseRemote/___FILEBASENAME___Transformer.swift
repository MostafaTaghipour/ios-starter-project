//  ___FILEHEADER___

import Foundation

extension ___VARIABLE_productName:identifier___DTO{
    func toJson()->___VARIABLE_productName:identifier___Json{
    return ___VARIABLE_productName:identifier___Json(id: id,title: title)
    }
}

extension ___VARIABLE_productName:identifier___Json{
    func toDTO()->___VARIABLE_productName:identifier___DTO{
    return ___VARIABLE_productName:identifier___DTO(id: id,title: title)
    }
}

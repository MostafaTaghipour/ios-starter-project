//  ___FILEHEADER___

import Foundation

extension ___VARIABLE_productName:identifier___Entity{
    func toDTO()->___VARIABLE_productName:identifier___DTO{
        return ___VARIABLE_productName:identifier___DTO(id: id,title: title)
    }
    
    func toJson()->___VARIABLE_productName:identifier___Json{
         return ___VARIABLE_productName:identifier___Json(id: id,title: title)
    }
}

extension ___VARIABLE_productName:identifier___DTO{
    func toEntity()->___VARIABLE_productName:identifier___Entity{
        let entity = ___VARIABLE_productName:identifier___Entity()
        entity.id = id
        entity.title = title
        return entity
    }
    
    func toJson()->___VARIABLE_productName:identifier___Json{
        return ___VARIABLE_productName:identifier___Json(id: id,title: title)
    }
}

extension ___VARIABLE_productName:identifier___Json{
    func toEntity()->___VARIABLE_productName:identifier___Entity{
        let entity = ___VARIABLE_productName:identifier___Entity()
        entity.id = id
        entity.title = title
        return entity
    }
    
    func toDTO()->___VARIABLE_productName:identifier___DTO{
        return ___VARIABLE_productName:identifier___DTO(id: id,title: title)
    }
}

//
//  AddressTransformer.swift
//  project
//
//  Created by Remote User on 4/18/18.
//  Copyright © 2018 hojan. All rights reserved.
//

import Foundation

extension SampleEntity{
    func toDTO()->SampleDTO{
        return SampleDTO(id: id,title: title)
    }
}

extension SampleDTO{
    func toEntity()->SampleEntity{
        let entity = SampleEntity()
        entity.id = id
        entity.title = title
        return entity
    }
}


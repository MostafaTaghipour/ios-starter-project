//
//  composeForHttpTasks.swift
//  project
//
//  Created by Remote User on 11/4/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import Foundation
import RxSwift
import  Moya

public extension ObservableType where E == Response {
    public func composeForHttpTasks() -> Observable<E> {
        
        return self
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .filterSuccessfulStatusAndRedirectCodes()
            .retryWhenTimeOut()
            .mapHttpError()
            .retryWithAuthIfNeeded()
            .observeOn(MainScheduler.instance)
    }
}


// With Single
extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    public func composeForHttpTasks() -> Single<E> {
        
        return self
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .filterSuccessfulStatusAndRedirectCodes()
            .retryWhenTimeOut()
            .mapHttpError()
            .retryWithAuthIfNeeded()
            .observeOn(MainScheduler.instance)
    }
}



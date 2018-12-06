//
//  ApiProvider.swift
//  project
//
//  Created by Remote User on 11/1/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import Common


class ApiProvider<Target> where  Target:TargetType{
    
    let provider:MoyaProvider<Target>!
    
    init() {
        
        let userAgent =  CurrentDevice.userAgent
        
        self.provider = MoyaProvider<Target>(
            manager: AlamofireSessionManager.sharedManager,
            plugins: [NetworkLoggerPlugin.init(),
                      TokenPlugin(),
                      UserAgentPlugin(userAgent: userAgent),
                      NetworkActivityPlugin.init(networkActivityClosure: { (activityType) in
                        switch activityType{
                        case .began:
                            DispatchQueue.main.async {
                                UIApplication.shared.isNetworkActivityIndicatorVisible=true
                            }
                            break
                        case .ended:
                            DispatchQueue.main.async {
                                UIApplication.shared.isNetworkActivityIndicatorVisible=false
                            }
                            break
                        }
                      })]
        )
        
    }
    
    
    func getProviderInstance() -> MoyaProvider<Target> {
        return self.provider
    }
    
    
    func request<T: Decodable>(_ target: Target,responseType:T.Type) -> Single<T> {
        return provider
            .rx
            .request(target)
            .composeForHttpTasks()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .map(responseType)
            .observeOn(MainScheduler.instance)
    }
    
    
    func request(_ target: Target) -> Single<Response> {
        return provider
            .rx
            .request(target)
            .composeForHttpTasks()
    }
    
    
    func requestMultipart(_ target: Target, tag:Int=0, progressDelegate: ProgressDelegate) -> Observable<Response> {
        return  provider
            .requestWithProgress(target, tag: tag, progressDelegate: progressDelegate)
            .asObservable()
            .composeForHttpTasks()
    }
}





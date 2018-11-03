//
//  RequestwithProgress.swift
//  project
//
//  Created by Remote User on 11/1/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Common


extension MoyaProvider  {
    
    public func requestWithProgress(_ target: Target, tag:Int=0, progressDelegate: ProgressDelegate) -> Single<Response> {
        
        let response: Single<Response> = Single.create {
            [weak self] observer in
            
            uiThread {
                progressDelegate.onStart(tag: tag)
            }
            
            let cancellableToken = self?.request(target, callbackQueue: nil, progress: { (progressResponse: ProgressResponse) in
                
                let prgrss=(progressResponse.progress*100).toInt()!
                
                uiThread {
                    progressDelegate.onProgress(tag: tag, percentage: prgrss)
                }
                
            }, completion: {
                result in
                
                switch result {
                case let .success(response):
                    uiThread {
                        progressDelegate.onFinish(tag: tag)
                    }
                    observer(.success(response))
                case let .failure(error):
                    uiThread {
                        progressDelegate.onFailed(tag: tag, error: error)
                    }
                    observer(.error(error))
                }
            })
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
        return response
    }
}


public protocol ProgressDelegate{
    func onStart(tag: Int)
    func onProgress(tag: Int, percentage: Int)
    func onFailed(tag: Int, error: Error)
    func onFinish(tag: Int)
}

extension ProgressDelegate{
    func onStart(tag: Int){}
    func onFailed(tag: Int, error: Error){}
    func onFinish(tag: Int){}
}

//
//  ErrorHandeling.swift
//  project
//
//  Created by Remote User on 11/1/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import Foundation
import RxSwift
import Moya



//MARK:- Retry when timeout
// With Single
extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    
    public func retryWhenTimeOut(maxAttempts:Int=3) ->  Single<Response> {
        return self.retryWhen{ (e: Observable<Error>) in
            Observable.zip(e, Observable.range(start: 1, count: maxAttempts)/*, resultSelector: { $1 }*/)
                .flatMap({ (err,i) -> Single<Int>  in
                    
                    
                    if let moyaError = err as? MoyaError,
                        case .underlying(let nsError as NSError, _ ) = moyaError,
                        nsError.code == NSURLErrorTimedOut {
                        return i>=maxAttempts ? Single.error(err) : Single.just(i)
                    }
                    else{
                        logError(error: err)
                        return Single.error(err)
                    }
                    
                    
                    
                })
        }
    }
}


// With Observable
public extension ObservableType where E == Response {
    
    public func retryWhenTimeOut(maxAttempts:Int=3) ->  Observable<Response> {
        return self.retryWhen{ (e: Observable<Error>) in
            Observable.zip(e, Observable.range(start: 1, count: maxAttempts)/*, resultSelector: { $1 }*/)
                .flatMap({ (err,i) -> Observable<Int>  in
                    
                    
                    if let moyaError = err as? MoyaError,
                        case .underlying(let nsError as NSError, _ ) = moyaError,
                        nsError.code == NSURLErrorTimedOut {
                        return i>=maxAttempts ? Observable.error(err) : Observable.just(i)
                    }
                    else{
                        logError(error: err)
                        return Observable.error(err)
                    }
                    
                    
                    
                })
        }
    }
}



//MARK:- Map HTTP error
// With Single
extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    
    public func mapHttpError() ->  Single<Response> {
        return self.catchError({ (error) -> PrimitiveSequence<SingleTrait, Response> in
            
            if let moyaError = error as? MoyaError{
                
                
                //UnauthorizedError
                if moyaError.statusCode==HttpStatusCode.Http401_Unauthorized{
                    return Single.error(UnauthorizedError())
                }
                
                
                
                let httpError=HttpError()
                httpError.statusCode = moyaError.statusCode
                
                if
                    let body = moyaError.response?.body,
                    !body.isEmpty,
                    let data = body.data(using: .utf8),
                    let errorBody = try? JSONDecoder().decode(HttpErrorBody.self,from: data){
                    
                    httpError.errorBody=errorBody
                    
                }
                
                
                return Single.error(httpError)
            }
            return Single.error(error)
        })
    }
}


// With Observable
public extension ObservableType where E == Response {
    public func mapHttpError() ->  Observable<Response> {
        return self.catchError({ (error) -> Observable<E> in
            
            if let moyaError = error as? MoyaError{
                
                //UnauthorizedError
                if moyaError.statusCode==HttpStatusCode.Http401_Unauthorized{
                    return Observable.error(UnauthorizedError())
                }
                
                
                let httpError=HttpError()
                httpError.statusCode = moyaError.statusCode
                
                if
                    let body = moyaError.response?.body,
                    !body.isEmpty,
                    let data = body.data(using: .utf8),
                    let errorBody = try? JSONDecoder().decode(HttpErrorBody.self,from: data){
                    
                    httpError.errorBody=errorBody
                    
                }
                
                
                return Observable.error(httpError)
            }
            return Observable.error(error)
        })
    }
}








fileprivate var authRetryAttempts = 0
//MARK:- Retry With Auth If Needed
// With Single
extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    /// Tries to refresh auth token on 401 errors and retry the request.
    /// If the refresh fails, the signal errors.
    public func retryWithAuthIfNeeded(maxAttempts:Int=3) ->  Single<Response> {
        return self.retryWhen{ (e: Observable<UnauthorizedError>) in
            Observable.zip(e, Observable.range(start: 1, count: maxAttempts)/*, resultSelector: { $1 }*/)
                .flatMap({ (error,i) -> Single<Int>  in
                    
                    //if more than 6 time get UnauthorizedError logout user
                    if authRetryAttempts>6{
                        authRetryAttempts = 0
                        Navigator.logout()
                        return Single.error(error)
                    }
                    
                    return i>=maxAttempts ? Single.error(error) : Single.just(i)
                    
                    
                    //                        return provider.rx.request(.refresh(token: "abc"))
                    //                            .filterSuccessfulStatusAndRedirectCodes()
                    //                            .map(Token.self)
                    //                            .catchError {  error  in
                    //                                if case MoyaError.statusCode(let response) = error  {
                    //                                    if response.statusCode == 401 {
                    //                                        // Logout
                    //                                        do {
                    //                                            try User.logOut()
                    //                                        } catch _ {
                    //                                            logger.warning("Failed to logout")
                    //                                        }
                    //                                    }
                    //                                }
                    //                                return Single.error(error)
                    //                            }.flatMap { token -> Single<Token> in
                    //                                do {
                    //                                    try token.saveInRealm()
                    //                                } catch let e {
                    //                                    logger.warning("Failed to save access token")
                    //                                    return Single.error(e)
                    //                                }
                    //                                return Single.just(token)
                    //                        }
                    
                })
        }
    }
}



// With Observable
public extension ObservableType where E == Response {
    /// Tries to refresh auth token on 401 errors and retry the request.
    /// If the refresh fails, the signal errors.
    public func retryWithAuthIfNeeded(maxAttempts:Int=3) ->  Observable<Response> {
        return self.retryWhen{ (e: Observable<UnauthorizedError>) in
            Observable.zip(e, Observable.range(start: 1, count: maxAttempts)/*, resultSelector: { $1 }*/)
                .flatMap({ (error,i) -> Observable<Int>  in
                    
                    
                    //if more than 6 time get UnauthorizedError logout user
                    if authRetryAttempts>6{
                        authRetryAttempts = 0
                        Navigator.logout()
                        return Observable.error(error)
                    }
                    return i>=maxAttempts ? Observable.error(error) : Observable.just(i)
                    
                    //                        return provider.rx.request(.refresh(token: "abc"))
                    //                            .filterSuccessfulStatusAndRedirectCodes()
                    //                            .map(Token.self)
                    //                            .catchError {  error  in
                    //                                if case MoyaError.statusCode(let response) = error  {
                    //                                    if response.statusCode == 401 {
                    //                                        // Logout
                    //                                        do {
                    //                                            try User.logOut()
                    //                                        } catch _ {
                    //                                            logger.warning("Failed to logout")
                    //                                        }
                    //                                    }
                    //                                }
                    //                                return Single.error(error)
                    //                            }.flatMap { token -> Single<Token> in
                    //                                do {
                    //                                    try token.saveInRealm()
                    //                                } catch let e {
                    //                                    logger.warning("Failed to save access token")
                    //                                    return Single.error(e)
                    //                                }
                    //                                return Single.just(token)
                    //                        }
                    
                    
                    
                })
        }
    }
}





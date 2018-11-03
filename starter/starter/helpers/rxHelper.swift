// Copyright (c) 2016 Marin Todorov <marin@underplot.com>

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import RxSwift
import RxCocoa
import MapKit
import UIKit
import Common


extension ObservableType {
    public func delay(time: TimeInterval, scheduler: SchedulerType = MainScheduler.instance) -> Observable<E> {
        return self.flatMap { element in
            Observable<Int>.timer(time, scheduler: scheduler)
                .map { _ in
                    return element
            }
        }
    }
}

// MARK: Two-Way Binding
infix operator <->
@discardableResult func <-><T>(property: ControlProperty<T>, variable: Variable<T>) -> Disposable {
    let variableToProperty = variable.asDriver()
        .drive(property)
    
    let propertyToVariable = property
        .subscribe(
            onNext: { variable.value = $0 },
            onCompleted: { variableToProperty.dispose() }
    )
    
    return Disposables.create(variableToProperty, propertyToVariable)
}


infix operator -->
@discardableResult func --><T>(variable: Variable<T>,property: AnyObserver<T>) -> Disposable {
    let variableToProperty = variable.asDriver()
        .drive(property)
    
    return Disposables.create([variableToProperty])
}



@discardableResult func --><T>(property: ControlProperty<T>,variable: Variable<T>) -> Disposable {
    let propertyToVariable = property
        .subscribe(
            onNext: { variable.value = $0 }
            )
    
    return Disposables.create([propertyToVariable])
}


//MARK:- scrollview+RX
extension UIScrollView {
    var rx_reachedBottom: Observable<Void> {
        return rx.contentOffset
            .flatMap { [weak self] contentOffset -> Observable<Void> in
                guard let scrollView = self else {
                    return Observable.empty()
                }
                
                let visibleHeight = scrollView.frame.height - scrollView.contentInset.top - scrollView.contentInset.bottom
                let y = contentOffset.y + scrollView.contentInset.top
                let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)
                
                if y==0 && threshold==0{
                   return  Observable.empty()
                }
                
                return y >= threshold ?  Observable<Void>.just(()) : Observable.empty()
        }
    }
    
    
    public var rx_startedDragging: Observable<Void> {
        let scrollView = self
        return scrollView.panGestureRecognizer.rx
            .event
            .filter({ $0.state == .began })
            .map({ _ in () })
    }
}

extension Reactive where Base:UIView{
    public var animatedVisibility: Binder<Bool> {
        return Binder(self.base) { view, visible in
            view.setVisibility(visible: visible)
        }
    }
}


// MARK: - UIViewController reactive extension
extension Reactive where Base: UIViewController {
 
    public var viewDidLoad: Observable<Void> {
        return self.sentMessage(#selector(UIViewController.viewDidLoad)).map({ _ in return () })
    }
    
    public var viewWillAppear: Observable<Bool> {
        return self.sentMessage(#selector(UIViewController.viewWillAppear(_:))).map({ $0.first as! Bool })
    }
    
    public var viewDidAppear: Observable<Bool> {
        return self.sentMessage(#selector(UIViewController.viewDidAppear(_:))).map({ $0.first as! Bool })
    }
    
    public var viewWillDisappear: Observable<Bool> {
        return self.sentMessage(#selector(UIViewController.viewWillDisappear(_:))).map({ $0.first as! Bool })
    }
    
    public var viewDidDisappear: Observable<Bool> {
        return self.sentMessage(#selector(UIViewController.viewDidDisappear(_:))).map({ $0.first as! Bool })
    }
}



//MARK:- Ignore nil
// Unfortunately the extra type annotations are required, otherwise the compiler gives an incomprehensible error.
extension Observable where Element: OptionalType {
    func ignoreNil() -> Observable<Element.Wrapped> {
        return flatMap { value in
            value.optional.map { Observable<Element.Wrapped>.just($0) } ?? Observable<Element.Wrapped>.empty()
        }
    }
}

extension Variable where Element: OptionalType {
    func asWrappedObservable() -> Observable<Element.Wrapped> {
        return asObservable().ignoreNil()
    }
}


//MARK:- Codable
public extension PrimitiveSequenceType where TraitType == MaybeTrait, ElementType == Data {
    public func map<T>(_ type: T.Type, using decoder: JSONDecoder? = nil) -> PrimitiveSequence<TraitType, T> where T: Decodable {
        return self.map { data -> T in
            let decoder = decoder ?? JSONDecoder()
            return try decoder.decode(type, from: data)
        }
    }
}

public extension PrimitiveSequenceType where TraitType == MaybeTrait, ElementType == String {
    public func map<T>(_ type: T.Type, using decoder: JSONDecoder? = nil) -> PrimitiveSequence<TraitType, T> where T: Decodable {
        return self
            .map { string in string.data(using: .utf8) ?? Data() }
            .map(type, using: decoder)
    }
}

public extension ObservableType where E == Data {
    public func map<T>(_ type: T.Type, using decoder: JSONDecoder? = nil) -> Observable<T> where T: Decodable {
        return self.map { data -> T in
            let decoder = decoder ?? JSONDecoder()
            return try decoder.decode(type, from: data)
        }
    }
}

public extension ObservableType where E == String {
    public func map<T>(_ type: T.Type, using decoder: JSONDecoder? = nil) -> Observable<T> where T: Decodable {
        return self
            .map { string in string.data(using: .utf8) ?? Data() }
            .map(type, using: decoder)
    }
}

public extension PrimitiveSequenceType where TraitType == SingleTrait, ElementType == Data {
    public func map<T>(_ type: T.Type, using decoder: JSONDecoder? = nil) -> PrimitiveSequence<TraitType, T> where T: Decodable {
        return self.map { data -> T in
            let decoder = decoder ?? JSONDecoder()
            return try decoder.decode(type, from: data)
        }
    }
}

public extension PrimitiveSequenceType where TraitType == SingleTrait, ElementType == String {
    public func map<T>(_ type: T.Type, using decoder: JSONDecoder? = nil) -> PrimitiveSequence<TraitType, T> where T: Decodable {
        return self
            .map { string in string.data(using: .utf8) ?? Data() }
            .map(type, using: decoder)
    }
}



//composeForIoTasks
extension PrimitiveSequence where TraitType == SingleTrait {
    public func composeForIoTasks() -> Single<E> {
        
        return self
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
    }
}


public extension ObservableType  {
    public func composeForIoTasks() -> Observable<E> {
        
        return self
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
    }
}



//single handler
extension PrimitiveSequence where TraitType == SingleTrait{
    func subscribe(_ handler: @escaping (E?,Error?)->()) -> Disposable {
        
        return  subscribe(onSuccess: { (element) in
            handler(element,nil)
        }) { (error) in
            handler(nil, error)
        }
        
    }
}








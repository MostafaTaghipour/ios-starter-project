//
//  CollectionsHelper.swift
//  Footkal
//
//  Created by Remote User on 5/7/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import Foundation


extension Collection {
  public  subscript(safe index: Index) -> Iterator.Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}

extension Sequence where Iterator.Element: OptionalType {
   public func removeNils() -> [Iterator.Element.Wrapped] {
        return self.compactMap { $0.optional }
    }
}

extension Optional where Wrapped: Collection {
 public   var isNilOrEmpty: Bool {
        switch self {
        case .some(let collection):
            return collection.isEmpty
        case .none:
            return true
        }
    }
}

extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
 public   mutating func remove(_ object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}


extension Array where Element : Hashable{
    
  public  mutating func remove(query:(Element) throws -> Bool) {
        if let res = try? self.filter(query){
            self.remove(res)
        }
    }
    
 public   mutating func remove(_ elements:[Element]) {
        elements.forEach { (item) in
            self.remove(item)
        }
    }
    
  public  mutating func upsert(_ element:Element , query:(Element) throws -> Bool) {
        if let i = try? index(where: query) , let index = i {
            self[index] = element
        }
        else{
            append(element)
        }
    }
    
  public  mutating func upsert(_ elements:[Element] , query:(Element,Element) -> Bool) {
        elements.forEach { (element) in
            if let i =  index(where: { (old) -> Bool in return query(old,element) })  {
                self[i] = element
            }
            else{
                append(element)
            }
        }
    }
    
   public var uniqueElements: [Iterator.Element] {
        return Array( Set(self) )
    }
}

extension Array{
   public func distinctBy<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        
        return arrayOrdered
    }
}



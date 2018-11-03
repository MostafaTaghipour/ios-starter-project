//  Convertor.swift
//  Footkal
//
//  Created by Remote User on 4/29/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import Foundation

extension String{
   public func toInt(defaultValue:Int?=nil)->Int?{
        return  Int(self) ?? defaultValue
    }
    
   public func toInt64(defaultValue:Int64?=nil)->Int64?{
        return  Int64(self) ?? defaultValue
    }
}



extension BinaryInteger{
   public func toString()->String{
        return  "\(self)"
    }
    
   public func toBool(defaultValue:Bool?=nil)->Bool?{
        return self == 0 ? false : self == 1 ? true : defaultValue
    }
}


extension Bool{
  public  func toInt()->Int?{
        return self ? 1 : 0
    }
}

extension Optional where Wrapped==Bool{
   public func toInt(defaultValue:Int?=nil)->Int?{
        return self == nil ? defaultValue : self == true ? 1 : 0
    }
}

extension Double {
   public func toInt(defaultValue:Int?=nil)-> Int? {
        if self > Double(Int.min) && self < Double(Int.max) {
            return Int(self)
        } else {
            return defaultValue
        }
    }
}

//extension CGFloat {
//    func toInt()-> Int {
//        return Int(self)
//    }
//}


extension Int64{
    public func toInt(defaultValue:Int?=nil)->Int?{
        return  Int(exactly:self) ?? defaultValue
    }
}


extension Int{
   public func toInt64()->Int64{
        return Int64(self)
    }
}


//
//  String.swift
//  Footkal
//
//  Created by Remote User on 4/20/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import UIKit




extension String {
    
    public  var isNotEmpty:Bool{
        return !isEmpty
    }
    
    public var length: Int {
        return self.count
    }
    
    public subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    public func substring(from: Int) -> String {
        return self[min(from, length) ..< length]
    }
    
    public func substring(to: Int) -> String {
        return self[0 ..< max(0, to)]
    }
    
    public  func substring(from: Int,to: Int) -> String {
        return self[min(from, length) ..< max(0, to)]
    }
    
    public func trimEnd()->String{
        return self.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
    }
    
    public func trimStart(chars: Set<Character>) -> String {
        if let index = self.index(where: {!chars.contains($0)}) {
            return String(self[index..<self.endIndex])
        } else {
            return ""
        }
    }
    
    
    public subscript (r: Range<Int>) -> String {
        let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    
}


extension Optional where Wrapped == String {
    public var isNilOrEmpty: Bool {
        switch self {
        case .some(let string):
            return string.isEmpty
        case .none:
            return true
        }
    }
    
    public var isNotNilAndEmpty: Bool {
        return !isNilOrEmpty
    }
}



extension String {
    public func transformToPersian() -> String {
        let numbersDictionary : Dictionary = ["0" : "۰","1" : "۱", "2" : "۲", "3" : "۳", "4" : "۴", "5" : "۵", "6" : "۶", "7" : "۷", "8" : "۸", "9" : "۹"]
        var str : String = self
        
        for (key,value) in numbersDictionary {
            str =  str.replacingOccurrences(of: key, with: value)
        }
        
        return str
    }
    
    public  func transformToLatin() -> String {
        let numbersDictionary : Dictionary = ["۰" : "0","۱" : "1", "۲" : "2", "۳" : "3", "۴" : "4", "۵" : "5", "۶" : "6", "۷" : "7", "۸" : "8", "۹" : "9"]
        var str : String = self
        
        for (key,value) in numbersDictionary {
            str =  str.replacingOccurrences(of: key, with: value)
        }
        
        return str
    }
}


extension String {
    public func guessLanguage() -> String? {
        
        if #available(iOS 11.0, *) {
            return NSLinguisticTagger.dominantLanguage(for: self)
        } else {
            let tagschemes = NSArray(objects: NSLinguisticTagScheme.language)
            let tagger = NSLinguisticTagger(tagSchemes: tagschemes as! [NSLinguisticTagScheme] , options: 0)
            tagger.string = self
            
            let language = tagger.tag(at: 0, scheme: NSLinguisticTagScheme.language, tokenRange: nil, sentenceRange: nil)?.rawValue
            return language
        }
    }
    
    public var isRTL:Bool{
        let language = guessLanguage()
        return language?.range(of: "he") != nil || language?.range(of:"ar") != nil || language?.range(of:"fa") != nil
    }
}

public let ltrEmbeddingChar = "\u{202A}"
public let rtlEmbeddingChar = "\u{202B}"
extension String {
    public  func forceRTL() -> String? {
        if self.isEmpty {
            return self
        }
        return rtlEmbeddingChar + self
    }
    
    public func forceLTR() -> String? {
        if self.isEmpty {
            return self
        }
        return ltrEmbeddingChar + self
    }
}





extension String {
   public func localized(tableName: String = "localizable" , arguments: CVarArg...) -> String {
        let t = StringResourceUtility.Localizer(tableName: tableName)
        return withVaList(arguments) { t(self, $0) }
    }
    
   public func localized(tableName: String = "localizable") -> String {
        return  NSLocalizedString(self, tableName: tableName, comment: "")
    }
}


class StringResourceUtility {
    static func Localizer(tableName: String?) -> (_ key: String, _ params: CVaListPointer) -> String {
        return { (key: String, params: CVaListPointer) in
            let content = NSLocalizedString(key, tableName: tableName, comment: "")
            return NSString(format: content, arguments: params) as String
        }
    }
}

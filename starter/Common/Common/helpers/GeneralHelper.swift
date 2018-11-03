//
//  GeneralHelper.swift
//  common
//
//  Created by Remote User on 10/31/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import Foundation
import MapKit

extension NotificationCenter {
   public func setObserver(_ observer: AnyObject, selector: Selector, name: NSNotification.Name, object: AnyObject?) {
        NotificationCenter.default.removeObserver(observer, name: name, object: object)
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: object)
    }
}


extension MKMapView{
   public func setCenter(_ location: CLLocationCoordinate2D, zoomLevel: Int, animated: Bool){
        let span = MKCoordinateSpan.init(latitudeDelta: 0, longitudeDelta: 360 / pow(2, Double(zoomLevel)) * Double(self.frame.size.width) / 256)
        setRegion(MKCoordinateRegion.init(center: location, span: span), animated: animated)
    }
}



extension BinaryInteger {
  public  func formattedWithThousandSeparator(seperator:String? = nil , locale : Locale = Locale.current) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let sep = seperator{
            formatter.groupingSeparator = sep
        }
        formatter.locale = locale
        return formatter.string(for: self) ?? ""
    }
}


extension Bundle {
    
   public static func loadView<T>(fromNib name: String) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }
        
    fatalError("Could not load view with type " + String(describing: T.self))
    }
}


extension NSObject {
    public class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}



public protocol OptionalType {
    associatedtype Wrapped
    var optional: Wrapped? { get }
}

extension Optional: OptionalType {
    public var optional: Wrapped? { return self }
}

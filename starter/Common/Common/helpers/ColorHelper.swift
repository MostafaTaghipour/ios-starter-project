//
//  ColorHelper.swift
//  common
//
//  Created by Remote User on 10/31/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import UIKit

extension UIColor{
   public class var infoLight: UIColor { return UIColor(red: 125/255, green: 208/255, blue: 239/255, alpha: 1)}
    public class var info: UIColor { return UIColor(red: 59/255, green: 170/255, blue: 255/255, alpha: 1)}
   public class var infoDark: UIColor { return UIColor(red: 49/255, green: 112/255, blue: 143/255, alpha: 1)}
   public class var errorLight: UIColor { return UIColor(red: 242/255, green: 131/255, blue: 143/255, alpha: 1)}
    public  class var error: UIColor { return UIColor(red: 249.0/255.0, green: 66.0/255.0, blue: 47.0/255.0, alpha: 1.0)}
   public class var errorDark: UIColor { return UIColor(red: 169/255, green: 68/255, blue: 67/255, alpha: 1)}
   public class var warningLight: UIColor {return UIColor(red: 255/255, green: 223/255, blue: 143/255, alpha: 1)}
     public class var warning: UIColor {return UIColor(red: 238.0/255.0, green: 189.0/255.0, blue: 34.0/255.0, alpha: 1.0)}
   public class var warningDark: UIColor { return UIColor(red: 144/255, green: 109/255, blue: 73/255, alpha: 1)}
   public class var successLight: UIColor { return UIColor(red: 184/255, green: 223/255, blue: 143/255, alpha: 1)}
   public  class var success: UIColor { return UIColor(red: 97.0/255.0, green: 161.0/255.0, blue: 23.0/255.0, alpha: 1.0)}
  public  class var successDark: UIColor { return UIColor(red: 67/255, green: 118/255, blue: 61/255, alpha: 1)}
}


public enum UIColorInputError : Error {
    case missingHashMarkAsPrefix,
    unableToScanHexValue,
    mismatchedHexStringLength
}

extension UIColor {
    /**
     The shorthand three-digit hexadecimal representation of color.
     #RGB defines to the color #RRGGBB.
     
     - parameter hex3: Three-digit hexadecimal value.
     - parameter alpha: 0.0 - 1.0. The default is 1.0.
     */
    public convenience init(hex3: UInt16, alpha: CGFloat = 1) {
        let divisor = CGFloat(15)
        let red     = CGFloat((hex3 & 0xF00) >> 8) / divisor
        let green   = CGFloat((hex3 & 0x0F0) >> 4) / divisor
        let blue    = CGFloat( hex3 & 0x00F      ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The shorthand four-digit hexadecimal representation of color with alpha.
     #RGBA defines to the color #RRGGBBAA.
     
     - parameter hex4: Four-digit hexadecimal value.
     */
    public convenience init(hex4: UInt16) {
        let divisor = CGFloat(15)
        let red     = CGFloat((hex4 & 0xF000) >> 12) / divisor
        let green   = CGFloat((hex4 & 0x0F00) >>  8) / divisor
        let blue    = CGFloat((hex4 & 0x00F0) >>  4) / divisor
        let alpha   = CGFloat( hex4 & 0x000F       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The six-digit hexadecimal representation of color of the form #RRGGBB.
     
     - parameter hex6: Six-digit hexadecimal value.
     */
    public convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The six-digit hexadecimal representation of color with alpha of the form #RRGGBBAA.
     
     - parameter hex8: Eight-digit hexadecimal value.
     */
    public convenience init(hex8: UInt32) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex8 & 0xFF000000) >> 24) / divisor
        let green   = CGFloat((hex8 & 0x00FF0000) >> 16) / divisor
        let blue    = CGFloat((hex8 & 0x0000FF00) >>  8) / divisor
        let alpha   = CGFloat( hex8 & 0x000000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     The hex string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, throws error.
     
     - parameter rgba: String value.
     */
    public convenience init(throws hex: String) throws {
        guard hex.hasPrefix("#") else {
            throw UIColorInputError.missingHashMarkAsPrefix
        }
        
        let hexString: String =  String(hex.suffix(from:  hex.index(hex.startIndex, offsetBy: 1)))

        var hexValue:  UInt32 = 0
        
        guard Scanner(string: hexString).scanHexInt32(&hexValue) else {
            throw UIColorInputError.unableToScanHexValue
        }
        
        switch (hexString.count) {
        case 3:
            self.init(hex3: UInt16(hexValue))
        case 4:
            self.init(hex4: UInt16(hexValue))
        case 6:
            self.init(hex6: hexValue)
        case 8:
            self.init(hex8: hexValue)
        default:
            throw UIColorInputError.mismatchedHexStringLength
        }
    }
    
    /**
     The hex string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, fails to default color.
     
     - parameter rgba: String value.
     */
    public convenience init(_ hex: String, defaultColor: UIColor = UIColor.clear) {
        guard let color = try? UIColor(throws: hex) else {
            self.init(cgColor: defaultColor.cgColor)
            return
        }
        self.init(cgColor: color.cgColor)
    }
    
    
    
    /**
     The rgba  representation of color with alpha percentage
     
     - parameter R: Int value (0 to 255).
       - parameter G: Int value (0 to 255).
       - parameter B: Int value (0 to 255).
       - parameter A: Int value (0 to 100).
     */
    public convenience init(R:Int,G:Int,B:Int,A:Int) {
        self.init(red: CGFloat(R/255), green: CGFloat(G/255), blue: CGFloat(B/255), alpha: CGFloat(A/100))
    }
    
   
    
    /**
     Hex string of a UIColor instance.
     
     - parameter includeAlpha: Whether the alpha should be included.
     */
    public func hexString(_ includeAlpha: Bool = true) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        if (includeAlpha) {
            return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
        } else {
            return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        }
    }
}



extension UIColor {
    func toImage() -> UIImage? {
        return toImageWithSize(size: CGSize(width: 1, height: 1))
    }
    func toImageWithSize(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        
        if let ctx = UIGraphicsGetCurrentContext() {
            let rectangle = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            ctx.setFillColor(self.cgColor)
            ctx.addRect(rectangle)
            ctx.drawPath(using: .fill)
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return colorImage
        } else {
            return nil
        }
    }
    
    
    
    func switchTo(color: UIColor, withPercentage: CGFloat) -> UIColor {
        var fromRed: CGFloat = 0.0
        var fromGreen: CGFloat = 0.0
        var fromBlue: CGFloat = 0.0
        var fromAlpha: CGFloat = 0.0
        
        self.getRed(&fromRed, green: &fromGreen, blue: &fromBlue, alpha: &fromAlpha)
        
        var toRed: CGFloat = 0.0
        var toGreen: CGFloat = 0.0
        var toBlue: CGFloat = 0.0
        var toAlpha: CGFloat = 0.0
        
        color.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha)
        
        //calculate the actual RGBA values of the fade colour
        let red = (toRed - fromRed) * withPercentage + fromRed
        let green = (toGreen - fromGreen) * withPercentage + fromGreen
        let blue = (toBlue - fromBlue) * withPercentage + fromBlue
        let alpha = (toAlpha - fromAlpha) * withPercentage + fromAlpha
        
        // return the fade colour
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

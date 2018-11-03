//
//  ImageHelper.swift
//  Footkal
//
//  Created by Remote User on 4/29/17.
//  Copyright © 2017 hojan. All rights reserved.
//

import UIKit

extension CGSize {
    // get scale of image size with max dimention
    public func scale(max: CGFloat) -> CGFloat {
        if width > height{
            if width > max {
                return max / width
            }
        } else {
            if height > max {
                return max / height
            }
        }
        return 1
        
    }
}

extension UIImage {
    // resize image with max dimention option
    public func resize(to maxDimention: CGFloat) -> UIImage {
        let aspect = self.size.scale(max: maxDimention)
        let newHeight = self.size.height * aspect
        let newWidth = self.size.width * aspect
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    public func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
    
    
    public   func imageWithAlpha(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    
    public  func saveImage(imageName:String="\(Date().toString(format: "yyyy-MM-dd-hh-mm-ss")).JPG",path:String=NSTemporaryDirectory())->URL?{
        let photoURL          = NSURL(fileURLWithPath: path)
        let localPath         = photoURL.appendingPathComponent(imageName)
        let data              = self.pngData()
        
        do
        {
            try data?.write(to: localPath!, options: Data.WritingOptions.atomic)
            return localPath
        }
        catch
        {
            return nil
        }
    }
    
    public  func saveImageInDocumentDirectory(imageName:String="\(Date().toString(format: "yyyy-MM-dd-hh-mm-ss")).JPG")->URL?{
        
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return saveImage(imageName: imageName, path: documentDirectory)
    }
    
    
    public func saveImageInTempDirectory(imageName:String="\(Date().toString(format: "yyyy-MM-dd-hh-mm-ss")).JPG")->URL?{
        return saveImage(imageName: imageName, path: NSTemporaryDirectory())
    }
    
}

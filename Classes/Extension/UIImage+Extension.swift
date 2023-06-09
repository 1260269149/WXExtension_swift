//
//  UIImage+Extension.swift
//  Calculator
//
//  Created by wangxu on 2020/11/26.
//  Copyright © 2020 wangxu. All rights reserved.
//

import UIKit

extension UIImage {
    class func `init`(color: UIColor, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect(origin: .zero, size: size))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func ellipse() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        let context = UIGraphicsGetCurrentContext()
        let rect = CGRect(origin: .zero, size: size)
        context?.addEllipse(in: rect)
        context?.clip()
        draw(in: rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? self;
    }
    
    func fixOrientation() -> UIImage {
        if imageOrientation != .up {
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            draw(in: CGRect(origin: .zero, size: size))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage ?? self
        }
        return self
    }
    
    func render(with color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(rect)
        draw(in: rect, blendMode: .overlay, alpha: 1)
        draw(in: rect, blendMode: .destinationIn, alpha: 1)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func resizeWith(_ size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(origin: .zero, size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    //修改图片颜色
    func imageWithTintColor(color : UIColor) -> UIImage?{
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)//kCGBlendModeNormal
        context?.setBlendMode(.normal)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context?.clip(to: rect, mask: self.cgImage!);
        color.setFill()
        context?.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    // 创建一个指定大小颜色的image
    class func image(_ color: UIColor, size: CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    // 压缩图片尺寸
    func scaleImageToSize(_ newSize: CGSize) -> UIImage {
        if newSize.equalTo(self.size) {
            return self
        }
        
        // Create a graphics image context
        UIGraphicsBeginImageContextWithOptions(newSize, true, UIScreen.main.scale)
        
        // new size
        self.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        
        // Get the new image from the context
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the context
        UIGraphicsEndImageContext()
        // Return the new image.
        return newImage!
    }
    func resizeleImageAddWhiteArea(_ newSize: CGSize) -> UIImage {
        //        // Create a graphics image context
        UIGraphicsBeginImageContext(newSize)
        
        let offsetX = ( newSize.width - self.size.width ) / 2.0
        let offsetY = ( newSize.height - self.size.height ) / 2.0
        // new size
        self.draw(in: CGRect(x: offsetX,y: offsetY,width: self.size.width,height: self.size.height))
        
        // Get the new image from the context
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the context
        UIGraphicsEndImageContext()
        // Return the new image.
        return newImage!
    }
    //压缩图片质量
    func reduceImageWithPercent(_ percent: CGFloat) -> UIImage? {
        if let imageData = self.jpegData(compressionQuality: percent){
            //UIImageJPEGRepresentation(self, percent) {
            let newImage =  UIImage(data: imageData)
            return newImage
        } else {
            return nil
        }
    }
}

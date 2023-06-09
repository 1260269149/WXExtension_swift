//
//  UIColor+Extension.swift
//  Calculator
//
//  Created by wangxu on 2020/9/29.
//  Copyright © 2020 wangxu. All rights reserved.
//

import UIKit

extension UIColor{
    
    class func initWith(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) -> UIColor{
        return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    convenience init(_ hex: UInt32) {
        var red, green, blue, alpha: UInt32
        if hex > 0xffffff {
            blue = hex & 0x000000ff
            green = (hex & 0x0000ff00) >> 8
            red = (hex & 0x00ff0000) >> 16
            alpha = (hex & 0xff000000) >> 24
        } else {
            blue = hex & 0x0000ff
            green = (hex & 0x00ff00) >> 8
            red = (hex & 0xff0000) >> 16
            alpha = 255
        }
        self.init(red: CGFloat(red) / (255.0), green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
    }
    /// 根据十六进制文字创建颜色
    class  func hexString(_ hexString:String,_ alpha:CGFloat = 1 ) -> UIColor {
        //处理数值
        var cString = hexString.uppercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let length = (cString as NSString).length
        if (length < 6 || length > 7 || (!cString.hasPrefix("#") && length == 7)){//错误处理
            return UIColor.white
        }
        if cString.hasPrefix("#"){
            cString = (cString as NSString).substring(from: 1)
        }
        //字符串截取
        var range = NSRange()
        range.location = 0
        range.length = 2
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        var r:UInt32 = 0,g:UInt32 = 0,b:UInt32 = 0 //存储转换后的数值
        //进行转换
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        //根据颜色值创建UIColor
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
    }
//    func toHexString() -> String{
//        let componets = self.cgColor.components
//        let r = componets?[0]
//        let g = componets?[1]
//        let b = componets?[2]
////        let a = componets?[3]
//        
//        let hixR = String(Int(r!*255), radix: 16)
//        let hixG = String(Int(g!*255), radix: 16)
//        let hixB = String(Int(b!*255), radix: 16)
//        
//        return "#\(hixR)\(hixG)\(hixB)"
//        
//    }
}

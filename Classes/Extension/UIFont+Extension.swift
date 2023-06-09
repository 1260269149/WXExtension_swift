//
//  UIFont+Extension.swift
//  zhaoshawang
//
//  Created by 王旭 on 2021/1/13.
//  Copyright © 2021 王旭. All rights reserved.
//

import UIKit
extension UIFont{
        
//    func scale()-> UIFont{
//        if font_size_scale >= 0.5 && font_size_scale <= 5{
//            return self.withSize(self.pointSize*font_size_scale)
//        }
//        return self
//    }
    /// 中等粗体方法
    ///
    /// - Parameter size: <#size description#>
    /// - Returns: <#return value description#>
    class func mediumFont(size:CGFloat) -> UIFont? {
        let font = UIFont(name: "PingFangSC-Medium", size: size)
        return font
        
    }
    
    /// 正常字体方法
    ///
    /// - Parameter size: <#size description#>
    /// - Returns: <#return value description#>
    class func regularFont(size:CGFloat) -> UIFont? {
        let font = UIFont(name: "PingFangSC-Regular", size: size)
        return font
    }
    
    /// 很粗粗体方法
    ///
    /// - Parameter size: <#size description#>
    /// - Returns: <#return value description#>
    class func boldFont(size:CGFloat) -> UIFont? {
        let font = UIFont.boldSystemFont(ofSize: size)//UIFont(name: "PingFang-SC-Bold", size: size)
        return font
        
    }
    /// 很粗粗体方法
    ///
    /// - Parameter size: <#size description#>
    /// - Returns: <#return value description#>
    class func semiboldFont(size:CGFloat) -> UIFont? {
        let font = UIFont(name: "PingFangSC-Semibold", size: size)
        return font
        
    }
    /// light 字体
    ///
    /// - Parameter size: <#size description#>
    /// - Returns: <#return value description#>
    class func lightFont(size:CGFloat) -> UIFont? {
        let font = UIFont(name: "PingFangSC-Light", size: size)
        return font
    }
    
}

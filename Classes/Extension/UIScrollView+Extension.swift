//
//  UIScrollView+Extension.swift
//  Calculator
//
//  Created by wangxu on 2020/10/16.
//  Copyright © 2020 wangxu. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    /// 截长屏Image
    var captureLongImage: UIImage? {
        
        //记录当前的scrollView的偏移量和坐标
        let currentContentOffSet = self.contentOffset
        let currentFrame = self.frame
        
        self.contentOffset = .zero
        self.frame = CGRect.init(x: 0, y: 0, width: self.contentSize.width, height: self.contentSize.height)
        
        // 参数：截屏区域， 是否透明， 清晰度
        UIGraphicsBeginImageContextWithOptions(self.contentSize, true, UIScreen.main.scale)
        if let context = UIGraphicsGetCurrentContext(){
            self.layer.render(in: context)
        }
       
        let img = UIGraphicsGetImageFromCurrentImageContext()
        
        //重新设置原来的参数
        self.contentOffset = currentContentOffSet
        self.frame = currentFrame
        
        UIGraphicsEndImageContext()
        
        return img
    }
}

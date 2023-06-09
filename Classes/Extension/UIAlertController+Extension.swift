//
//  UIAlertController+Extension.swift
//  Calculator
//
//  Created by wangxu on 2022/10/8.
//  Copyright © 2022 wangxu. All rights reserved.
//

import UIKit

extension UIAlertController{
    
    func fitIPad(target: UIViewController)->UIAlertController{
        //适配 ipad
        let isIPad = UIDevice.current.name.contains("iPad")
        if isIPad{
            self.popoverPresentationController?.sourceView = target.view
            self.popoverPresentationController?.sourceRect = target.view.frame
        }
        return self
    }
}

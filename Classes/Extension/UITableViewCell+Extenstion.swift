//
//  UITableViewCell+Extenstion.swift
//  DoctorProject
//
//  Created by wangxu on 2020/7/23.
//  Copyright © 2020 Ly. All rights reserved.
//

import UIKit

extension UITableViewCell{
    class func tableCellFromNib<T>(_ aClass: T.Type) -> T {
        let name = String(describing: aClass)
        if Bundle.main.path(forResource: name, ofType: "nib") != nil {
            return UINib(nibName: name, bundle:nil).instantiate(withOwner: nil, options: nil)[0] as! T
        } else {
            fatalError("\(String(describing: aClass)) nib is not exist")
        }
    }
    
    static var reuseID: String {
        return NSStringFromClass(self.classForCoder())
    }
    
}


extension UITableViewHeaderFooterView {
    static var reuseID: String {
        return NSStringFromClass(self.classForCoder())
    }
    static func headerFooterForNib<T>(aClass: T.Type) -> T?{
        let name = String(describing: aClass)
        if Bundle.main.path(forResource: name, ofType: "nib") != nil{
            return UINib.init(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil).first as? T
        }else{
            fatalError("\(String(describing: aClass)) nib is not exist")
        }
    }
    static func headerFooterForClass<T>(aClass: T.Type) -> T?{
        let name = String(describing: aClass)
        return UITableViewHeaderFooterView.init(reuseIdentifier: name) as? T
    }
}

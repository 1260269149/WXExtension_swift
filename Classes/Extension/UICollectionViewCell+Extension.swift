//
//  UICollectionViewCell+Extension.swift
//  Calendar
//
//  Created by wangxu on 2023/3/30.
//

import UIKit

extension UICollectionViewCell{
    class func colCellFormNib<T>(_ aClass: T.Type)->T{
        let name = String(describing: aClass)
        if Bundle.main.path(forResource: name, ofType: "nib") != nil{
            return UINib.init(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil).first as! T
        }else {
            fatalError("\(String(describing: aClass)) nib is not exist")
        }
    }
    @objc static var reuseId: String{
        return NSStringFromClass(self.classForCoder())
    }
}
extension UICollectionReusableView {
    static var reuseID: String {
        return NSStringFromClass(self.classForCoder())
    }
    static func reuseableForNib<T>(aClass: T.Type) -> T?{
        let name = String(describing: aClass)
        if Bundle.main.path(forResource: name, ofType: "nib") != nil{
            return UINib.init(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil).first as? T
        }else{
            fatalError("\(String(describing: aClass)) nib is not exist")
        }
    }
}

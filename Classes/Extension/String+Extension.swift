//
//  String+Extension.swift
//  Calculator
//
//  Created by wangxu on 2020/9/30.
//  Copyright © 2020 wangxu. All rights reserved.
//

import UIKit

extension String{
    
    var isNumberStr: Bool{
        let scan = Scanner.init(string: self)
        var val: Double = 0.0
        return scan.scanDouble(&val) && scan.isAtEnd
    }
    var isTimeStr: Bool{//不能验证2月30和31
        let timeGex = "([1-9][0-9]{3})-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])"
        let regex = NSPredicate.init(format: "SELF MATCHES %@", timeGex)
        return regex.evaluate(with: self)
    }
    //类型转换
    /// String: 转化为Int
    var int: Int? {
      guard let num = NumberFormatter().number(from: self) else { return nil }
      return num.intValue
    }

    /// String: 转化为 Double
    var double: Double? {
        if self.isNumberStr{
            guard let num = NumberFormatter().number(from: self) else{ return nil }
            return num.doubleValue
        }else{
            return nil
        }
    }

    /// String: 转化为Float
    var float: Float? {
      guard let num = NumberFormatter().number(from: self) else{ return nil }
      return num.floatValue
    }

    /// String: 转化为 NSNumber
    var number: NSNumber? {
      guard let num = NumberFormatter().number(from: self) else{ return nil }
      return num
    }

    /// String: 转化为 Bool
    var bool: Bool? {
      if let num = NumberFormatter().number(from: self) {
        return num.boolValue
      }
      switch self.lowercased() {
      case "true","yes": return true
      case "false","no": return false
      default: return nil
      }
    }
    
    func toImage(tintColor: UIColor? = nil) -> UIImage? {
        if tintColor == nil{
            return UIImage(named: self)
        }
        return UIImage(named: self)?.imageWithTintColor(color: tintColor!)
    }
    func toSFImage(tintColor: UIColor) -> UIImage?{
        // 1.可以配置 weight、scale、textStyle等
        let config = UIImage.SymbolConfiguration(weight: .regular)
        // 2.初始化`UIImage`，当然也可以不传 Configuration
        let tempImg =  UIImage(systemName: self, withConfiguration: config)
        // 3.修改颜色 和 mode
        let img = tempImg?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
        return img
    }
    var toColor:UIColor? {
        return UIColor.hexString(self)
    }
    func toNoti() -> NSNotification.Name {
        let noti = NSNotification.Name.init(self)
        return noti
    }
    func removeFirst() -> String{
        var str = self
        if str.count > 0{
            str = str.substingInRange(1..<str.count) ?? ""
        }
        return str
    }
    func removeLast() -> String{
        var str = self
        if str.count > 0{
            str = str.substingInRange(0..<str.count - 1) ?? ""
        }
        return str
    }
    func append(_ newStr: String?) -> String{
        return self + (newStr ?? "")
    }
    //获取子字符串
    func substingInRange(_ r: Range<Int>) -> String? {
        if r.lowerBound < 0 || r.upperBound > self.count {
            return nil
        }
        let startIndex = self.index(self.startIndex, offsetBy:r.lowerBound)
        let endIndex   = self.index(self.startIndex, offsetBy:r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    /// 获取字符串尺寸
    /// - Parameters:
    ///   - maxW: <#maxW description#>
    ///   - maxH: <#maxH description#>
    ///   - attributes: <#attributes description#>
    /// - Returns: <#description#>
    func boundsSize(maxW: CGFloat, maxH: CGFloat, attributes: [NSAttributedString.Key: Any]?) -> CGSize{
        let ocStr = NSString.init(string: self)
        let size = ocStr.boundingRect(with: CGSize.init(width: maxW, height: maxH), options: .usesLineFragmentOrigin, attributes: attributes,context: nil).size
        return size
    }
    
    func toHtmlAttributedText() -> NSAttributedString? {
        
        guard let data = self.data(using: String.Encoding.utf8,allowLossyConversion: true) else { return nil }
        let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [

        NSAttributedString.DocumentReadingOptionKey.characterEncoding : String.Encoding.utf8.rawValue,

        NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html,

        ]

        let htmlString = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil)

        //this to have borders in html table

//        htmlString?.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.clear, range: NSMakeRange(0, 1))

        return htmlString
    }
}

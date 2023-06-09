//
//  UILabel+Extension.swift
//  DoctorProject
//
//  Created by Ly on 2020/7/20.
//  Copyright © 2020 Ly. All rights reserved.
//

import UIKit

public extension UILabel {
    
    class func wxCreateLabel(text: String, font: UIFont?, textColor: UIColor? = .black, backgroundColor: UIColor? = .clear, textAlignment: NSTextAlignment? = .center, numberOfLines: Int? = 1) -> UILabel {
        return wx_classLabel(text: text, textColor: textColor, backgroundColor: .clear, font: font, textAlignment: textAlignment, numberOfLines: numberOfLines)
    }
    class func wxCreateLabel(text: String, fontSize: CGFloat? , textColor: UIColor? = .black, backgroundColor: UIColor? = .clear, textAlignment: NSTextAlignment? = .center, numberOfLines: Int? = 1) -> UILabel {
        return wx_classLabel(text: text, textColor: textColor, backgroundColor: backgroundColor, font: UIFont.systemFont(ofSize: fontSize ?? 17), textAlignment: textAlignment, numberOfLines: numberOfLines)
    }
    class func wxCreateLabel(attText: NSAttributedString?, textColor: UIColor? = .black, backgroundColor: UIColor? = .clear, font: UIFont?, textAlignment: NSTextAlignment? = .center, numberOfLines: Int? = 0) -> UILabel {
        return wx_classLabel(attText: attText, textColor: textColor, backgroundColor: .clear, font: font, textAlignment: textAlignment, numberOfLines: numberOfLines)
    }
    class func wxCreateLabel(attText: NSAttributedString?, textColor: UIColor? = .black, backgroundColor: UIColor? = .clear, fontSize: CGFloat? , textAlignment: NSTextAlignment? = .center, numberOfLines: Int? = 0) -> UILabel {
        return wx_classLabel(attText: attText, textColor: textColor, backgroundColor: backgroundColor, font: UIFont.systemFont(ofSize: fontSize ?? 17), textAlignment: textAlignment, numberOfLines: numberOfLines)
    }
    
}
fileprivate extension UILabel {
    
    class func wx_classLabel(text: String? = nil, attText: NSAttributedString? = nil, textColor: UIColor?, backgroundColor: UIColor?, font: UIFont?, textAlignment: NSTextAlignment?, numberOfLines: Int?) -> Self {
        let label = self.init()
        label.text = text
        if (attText != nil){//给富文本赋值之后，text会失效
            label.attributedText = attText
        }
        label.textColor = textColor
        label.font = font ?? UIFont.systemFont(ofSize: 17)
        label.textAlignment = textAlignment ?? .center
        label.numberOfLines = numberOfLines ?? 1
        label.backgroundColor = backgroundColor
        return label
    }
}

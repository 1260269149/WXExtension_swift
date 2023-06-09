//
//  UIButton+Extension.swift
//  DoctorProject
//
//  Created by Ly on 2020/7/20.
//  Copyright © 2020 Ly. All rights reserved.
//

import Foundation
import UIKit
//import Kingfisher

public extension UIButton {

//    func nf_setImageWithURL(_ urlString: String?, placeholderImage: UIImage?) {
//        if urlString?.isEmpty ?? true {
//            sd_setImage(with: nil, for: .normal, placeholderImage: placeholderImage, options: SDWebImageOptions.retryFailed, completed: nil)
//        } else {
//            let url = URL(string: urlString!.fullImagePath)
//           sd_setImage(with: url, for: .normal, placeholderImage: placeholderImage, options: SDWebImageOptions.retryFailed, completed: nil)
//        }
//    }
//
//    func nf_setBgImageWithURL(_ urlString: String?, placeholderImage: UIImage?) {
//        if urlString?.isEmpty ?? true {
//            self.setBackgroundImage(placeholderImage, for: .normal)
//        } else {
//            let url = URL(string: urlString!.fullImagePath)
//            sd_setBackgroundImage(with: url, for: .normal, placeholderImage: placeholderImage, options: .retryFailed, completed: nil)
//        }
//    }
    
    
//    func kf_setImageWithURL(_ urlString: String?, placeholderImage: UIImage? = nil, completion: CompletionHandler? = nil) {
//        if urlString?.isEmpty ?? true {
//            setImage(placeholderImage, for: .normal)
//        } else {
//            let url = URL(string: urlString!.fullPath)
//
//            kf.setImage(with: url, for: .normal, placeholder: placeholderImage, options: nil, progressBlock: nil, completionHandler: completion)
//        }
//    }
//
//    func kf_setBgImageWithURL(_ urlString: String?, placeholderImage: UIImage? = nil, completion: CompletionHandler? = nil) {
//        if urlString?.isEmpty ?? true {
//            self.setBackgroundImage(placeholderImage, for: .normal)
//        } else {
//            let url = URL(string: urlString!.fullPath)
//            kf.setBackgroundImage(with: url, for: .normal, placeholder: placeholderImage, options: nil, progressBlock: nil, completionHandler: completion)
//        }
//    }
    
    static func wx_createButton(image: UIImage? = nil, title: String? = "", titleColor: UIColor? = .blue, font: CGFloat = 15, backColor: UIColor? = .clear, borderColor: UIColor? = .clear, cornerRadius: CGFloat? = nil, touchHandle: ((_ btn: UIButton?) -> Swift.Void)?) -> UIButton{

        return createButton(image: image, title: title, titleColor: titleColor, font: UIFont.systemFont(ofSize: font), backColor: backColor, borderColor: borderColor, cornerRadius: cornerRadius, touchHandle: touchHandle)
    }
    fileprivate static func createButton(image: UIImage?, title: String?, titleColor: UIColor?, font: UIFont?, backColor: UIColor? = .clear, borderColor: UIColor?, cornerRadius: CGFloat?, touchHandle: ((_ btn: UIButton?) -> Swift.Void)?) -> UIButton{
        let button = self.init(type: .custom)
        button.setImage(image, for: .normal)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = font
        button.backgroundColor = backColor
        button.layer.borderWidth = 1
        button.layer.borderColor = borderColor?.cgColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = cornerRadius ?? 0
        button.wx_addSelectedTap { (b) in
            touchHandle?(b as? UIButton)
        }
        return button
    }
}

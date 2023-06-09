//
//  UIImageView+Extension.swift
//  Calendar
//
//  Created by wangxu on 2023/4/7.
//
import UIKit
import Kingfisher
extension UIImageView {

    func kf_setImageWithURL(_ urlString: String?, placeholderImage: UIImage? = nil, completion: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {

        if urlString?.count ?? 0 > 0{
            let base64Str = urlString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: base64Str!)
            self.kf.setImage(with: url, placeholder: placeholderImage, options: nil, progressBlock: nil, completionHandler: completion)
        }
    }
}

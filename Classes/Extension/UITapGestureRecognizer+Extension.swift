//
//  UITapGestureRecognizer+Extension.swift
//  Longmen2
//
//  Created by git burning on 2019/12/16.
//  Copyright © 2019 BoostVision. All rights reserved.
//

import Foundation
import UIKit

extension UITapGestureRecognizer {
    
    public convenience init(target: Any?, handler: ((_ tap:UITapGestureRecognizer)->Void)?) {
        self.init(target: nil, action: nil)
        self.addTarget(self, action: #selector(didTapedBarButton))
        self.boost_handler = handler
    }
    
    @objc private func didTapedBarButton() {
        self.boost_handler?(self)
    }
    
    class TapWrapper {
        var closure: ((_ tap:UITapGestureRecognizer) -> Void)?
        
        init(_ closure: ((_ tap:UITapGestureRecognizer) -> Void)?) {
            self.closure = closure
        }
    }
    
    fileprivate struct AssociatedKeys {
        static var HandlerKey = "HandlerKeyTap"
    }
    
    private  var boost_handler: ((_ tap:UITapGestureRecognizer)->Void)? {
        get {
            let obj = objc_getAssociatedObject(self, &AssociatedKeys.HandlerKey) as? TapWrapper
            return obj?.closure
        }
        
        set(newHandler) {
            objc_setAssociatedObject(self, &AssociatedKeys.HandlerKey, TapWrapper(newHandler), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
extension UILongPressGestureRecognizer{
    public convenience init(target: Any?, handler: ((_ tap:UILongPressGestureRecognizer)->Void)?) {
        self.init(target: nil, action: nil)
        self.addTarget(self, action: #selector(didTapedBarButton))
        self.boost_handler = handler
    }
    
    @objc private func didTapedBarButton() {
        self.boost_handler?(self)
    }
    
    class TapWrapper {
        var closure: ((_ tap:UILongPressGestureRecognizer) -> Void)?
        
        init(_ closure: ((_ tap:UILongPressGestureRecognizer) -> Void)?) {
            self.closure = closure
        }
    }
    
    fileprivate struct AssociatedKeys {
        static var HandlerKey = "HandlerKeyTap"
    }
    
    private  var boost_handler: ((_ tap:UILongPressGestureRecognizer)->Void)? {
        get {
            let obj = objc_getAssociatedObject(self, &AssociatedKeys.HandlerKey) as? TapWrapper
            return obj?.closure
        }
        
        set(newHandler) {
            objc_setAssociatedObject(self, &AssociatedKeys.HandlerKey, TapWrapper(newHandler), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

//
//  UIView+Extension.swift
//  Calculator
//
//  Created by wangxu on 2020/10/14.
//  Copyright © 2020 wangxu. All rights reserved.
//

import UIKit
import GoogleMobileAds

/// 广告加载
extension UIView{
    func addGADBannerView(id: String, closeHandel: ((_ adBannerView: UIView)->())?){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1) {
            if true{//加了内购就去广告
                let bannerView = GADBannerView(adSize: GADAdSizeBanner)
                self.addSubview(bannerView)
                self.bringSubviewToFront(bannerView)
                
                bannerView.backgroundColor = .clear
                bannerView.translatesAutoresizingMaskIntoConstraints = false
                bannerView.adUnitID = id
                bannerView.rootViewController = self.controller
                bannerView.delegate = self
                bannerView.load(GADRequest())
                
                bannerView.snp.makeConstraints { (make) in
                    make.centerX.equalToSuperview()
                    make.top.equalTo(0)
                    make.size.equalTo(gAdBannerSize)
                }
                
                if closeHandel != nil{
                    let close = UIButton.wx_createButton(image: UIImage.init(named: "删除")?.imageWithTintColor(color: .systemGroupedBackground), backColor: .clear, borderColor: .systemGroupedBackground, cornerRadius: 8) { btn in
                        closeHandel?(bannerView)
                    }
                    bannerView.addSubview(close)
                    bannerView.bringSubviewToFront(close)
                    close.snp.makeConstraints { make in
                        make.right.equalTo(bannerView).offset(-5)
                        make.top.equalTo(bannerView).offset(5)
                        make.width.equalTo(16)
                        make.height.equalTo(16)
                    }
                }
            }
        }
    }
    
    func addGADJiLiView(completionBlock: @escaping((_ rewordAd: GADRewardedAd?)->()), errBlock: @escaping((_ err: Error)->())){
        GADRewardedAd.load(withAdUnitID: jiLiAdId, request: GADRequest()) { ad, err in
            if let err = err{
                errBlock(err)
                return
            }
            ad?.fullScreenContentDelegate = self
            completionBlock(ad)
        }
    }
}
extension UIView: GADNativeAdLoaderDelegate, GADBannerViewDelegate, GADFullScreenContentDelegate{
    public func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
        print(nativeAd)
    }
    
    public func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
        print(error)
    }
    
    public func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {

    }
    public func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        bannerView.removeFromSuperview()
        print(error)
    }
    
    public func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("didFailToPresentFullScreenContentWithError")
        
    }
    public func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("adDidDismissFullScreenContent")
    }
}

extension UIView{
    func removeSubviewsWithTags(_ tags: [Int]){
        self.subviews.forEach { (v) in
            tags.forEach({ tag in
                if v.tag == tag{
                    v.removeFromSuperview()
                }
            })
        }
    }
    func removeSubviews(){
        self.subviews.forEach { (v) in
            v.removeFromSuperview()
        }
    }
    func wx_addSelectedTap(handler: ((_ view:UIView?)->())?) {
        
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self) { (tap) in
            handler?(tap.view)
        }
        self.addGestureRecognizer(tap)
    }
    func wx_addLongTap(handler: ((_ view:UIView?)->())?){
        self.isUserInteractionEnabled = true
        let longTap = UILongPressGestureRecognizer(target: self) { (longTap) in
            handler?(longTap.view)
        }
        self.addGestureRecognizer(longTap)
    }
    
    @discardableResult
    func wx_addButtomLine(left:CGFloat = 0 ,right:CGFloat = 0, color: UIColor? = .groupTableViewBackground) -> UIView {
        var line = self.viewWithTag(9999991) as? UILabel
        if line != nil {
            line?.snp.updateConstraints({
                $0.left.equalTo(left)
                $0.right.equalTo(right)
            })
            return line!
        }
        else{
            line = UILabel()
            line?.tag = 9999991
            self.addSubview(line!)
            line?.snp.makeConstraints({ (maek) in
                maek.bottom.equalTo(0)
                maek.height.equalTo(1)
                maek.left.equalTo(left)
                maek.right.equalTo(right)
            })
            line?.backgroundColor = color
            return self
        }
    }
    @discardableResult
    func wx_addTopLine(left:CGFloat = 0 ,right:CGFloat = 0, color: UIColor? = .systemGroupedBackground) -> UIView {
        var line = self.viewWithTag(9999992) as? UILabel
        if line != nil {
            line?.snp.updateConstraints({
                $0.left.equalTo(left)
                $0.right.equalTo(right)
            })
            return line!
        }
        else{
            line = UILabel()
            line?.tag = 9999992
            self.addSubview(line!)
            line?.snp.makeConstraints({ (maek) in
                maek.top.equalTo(0)
                maek.height.equalTo(1)
                maek.left.equalTo(left)
                maek.right.equalTo(right)
            })
            line?.backgroundColor = color
            return self
        }
    }
    ///设置边框
    func wx_border(borderColor:UIColor = .black, borderWidth: CGFloat = 1)  {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    ///设置圆角和边框
    func wx_cornerAndBorder(cornerRadius: CGFloat, masksToBounds: Bool = true, borderColor:UIColor, borderWidth: CGFloat = 1)  {
        self.layer.masksToBounds = masksToBounds
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    /// 增加部分圆角
    @discardableResult
    func wx_addCorner(radius:CGFloat, corners: UIRectCorner) -> CALayer {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners:corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        return maskLayer
    }
    /// 增加顶部圆角
    ///
    /// - Parameter radii: <#radii description#>
    /// - Returns: <#return value description#>
    @discardableResult
    func wx_addTopCorner(radius:CGFloat) -> CALayer {
        let corners:UIRectCorner = [UIRectCorner.topRight,UIRectCorner.topLeft]
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners:corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        return maskLayer
    }
    
    @discardableResult
    func wx_addLeftCorner(radius:CGFloat,size:CGSize) -> CALayer {
        let tempFrame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let corners:UIRectCorner = [UIRectCorner.bottomLeft,UIRectCorner.topLeft]
        let maskPath = UIBezierPath(roundedRect: tempFrame, byRoundingCorners:corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = tempFrame//self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        return maskLayer
    }
    
    @discardableResult
    func wx_addRightCorner(radius:CGFloat,size:CGSize) -> CALayer {
        let tempFrame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let corners:UIRectCorner = [UIRectCorner.bottomRight,UIRectCorner.topRight]
        let maskPath = UIBezierPath(roundedRect: tempFrame, byRoundingCorners:corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = tempFrame//self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        return maskLayer
    }
    @discardableResult
    func wx_addBottomCorner(radius:CGFloat) -> CALayer {
        let corners:UIRectCorner = [UIRectCorner.bottomLeft,UIRectCorner.bottomRight]
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners:corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        return maskLayer
    }
    
    /// 水平渐变
    func wx_horizontalGradientLayer(colors: [CGColor], cornerRadius:CGFloat) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        
        if colors.count == 1{
            gradient.backgroundColor = colors.first
        }else{
            gradient.colors = colors
        }
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.cornerRadius = cornerRadius
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    /// 垂直渐变
    func wx_verticalGradientLayer(colors: [CGColor], cornerRadius:CGFloat) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        
        if colors.count == 1{
            gradient.backgroundColor = colors.first
        }else{
            gradient.colors = colors
        }
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.cornerRadius = cornerRadius
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    ///给View添加阴影
    func wx_shadow( shadowColor:UIColor, shadowOffset:CGSize, shadowOpacity:Float, shadowRadius:CGFloat) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = shadowOffset
    }
    
    ///给View添加阴影和边框
    func wx_shadowBorder( shadowColor:UIColor, shadowOffset:CGSize, shadowOpacity:Float, shadowRadius:CGFloat, borderColor: UIColor) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = shadowOffset
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1.0
    }
    
    ///获取当前View的控制器
    func wx_viewGetcurrentVC() -> UIViewController? {
        var nextResponder: UIResponder? = self
        repeat {
            nextResponder = nextResponder?.next
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
        } while nextResponder != nil
        
        return nil
    }
    
    ///view转图片
    func wx_viewToImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

public extension UIView {
    
    var height:CGFloat {
        get {
            return frame.height
        }
        set(newValue){
            var tempFrame = self.frame
            tempFrame.size.height = newValue
            self.frame = tempFrame
        }
    }
    
    var width:CGFloat {
        get{
            return frame.width
        }
        
        set(newValue){
            var tempFrame = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    var x:CGFloat {
        get{
            return frame.origin.x
        }
        set(newValue){
            var tempFrame = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    
    var centerX:CGFloat {
        get{
            return center.x
        }
        set(newValue){
            var tempCenter = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    var centerY:CGFloat {
        get{
            return center.y
        }
        set(newValue){
            var tempCenter = center
            tempCenter.y = newValue
            center = tempCenter
        }
    }
    
    var y:CGFloat {
        get{
            return frame.origin.y
        }
        set(newValue){
            var tempFrame = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }
    
    /// left值
    var left: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            var tempFrame = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    
    /// top值
    var top: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            var tempFrame = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }
    
    /// right值
    var right: CGFloat {
        get {
            return frame.origin.x + frame.size.width
        }
        set {
            var tempFrame = frame
            tempFrame.origin.x = newValue - frame.size.width
            frame = tempFrame
        }
    }
    
    /// bottom值
    var bottom: CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
        set {
            var tempFrame = frame
            tempFrame.origin.y = newValue - frame.size.height
            frame = tempFrame
        }
    }
    
    /// size值
    var size: CGSize {
        get {
            return frame.size
        }
        set {
            var tempFrame = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    /// origin值
    var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
            var tempFrame = frame
            tempFrame.origin = newValue
            frame = tempFrame
        }
    }
}
//MARK: --- 常用的方法

fileprivate extension UIView {
    
    /// 点击手势(默认代理和target相同)
    func wx_longGesture(target: Any?, action: Selector, numberOfTapsRequired: Int = 1) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        tapGesture.numberOfTapsRequired = numberOfTapsRequired
        tapGesture.delegate = target as? UIGestureRecognizerDelegate
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
    
    /// 长按手势(默认代理和target相同)
    func wx_longGesture( target: Any?, action: Selector, minDuration: TimeInterval = 0.5) {
        let longGesture = UILongPressGestureRecognizer(target: target, action: action)
        longGesture.minimumPressDuration = minDuration
        longGesture.delegate = target as? UIGestureRecognizerDelegate
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(longGesture)
    }
    
    /// 截图(带导航则用导航控制器的view或keywindow)
    func wx_screenshotImage() -> UIImage? {
        UIGraphicsBeginImageContext(self.bounds.size)
        if self.responds(to: #selector(UIView.drawHierarchy(in:afterScreenUpdates:))) {
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: false)
        } else if self.layer.responds(to: #selector(CALayer.render(in:) )) {
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
        } else {
            return nil
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            return layer.shadowColor != nil ? UIColor(cgColor: layer.shadowColor!) : nil
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    var shadowPath: CGPath? {
        get {
            return layer.shadowPath
        }
        set {
            layer.shadowPath = newValue
        }
    }
    
    var controller: UIViewController? {
        get {
            var nextResponder: UIResponder?
            nextResponder = next
            repeat {
                if nextResponder is UIViewController {
                    return (nextResponder as! UIViewController)
                } else {
                    nextResponder = nextResponder?.next
                }
            } while nextResponder != nil
            return nil
        }
    }
}

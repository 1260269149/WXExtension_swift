//
//  UITableView+Extension.swift
//  DoctorProject
//
//  Created by Ly on 2020/7/28.
//  Copyright © 2020 Ly. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import MJRefresh
import DZNEmptyDataSet

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(with cellClass: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: cellClass)
        var cell = dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = T(style: .default, reuseIdentifier: identifier)
        }
        return cell as! T
    }
    
    func dequeueReusableCell<T: UITableViewCell>(nib cellClass: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: cellClass)
        var cell = dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = T.tableCellFromNib(T.self)
        }
        return cell as! T
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(class headerFooterClass: T.Type)->T?{
        let identifier = String(describing: headerFooterClass)
        var headerFooter = dequeueReusableHeaderFooterView(withIdentifier: identifier)
        if headerFooter == nil{
            headerFooter = T.headerFooterForClass(aClass: T.self)
        }
        return headerFooter as? T
    }
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(nib headerFooterClass: T.Type)->T?{
        let identifier = String(describing: headerFooterClass)
        var headerFooter = dequeueReusableHeaderFooterView(withIdentifier: identifier)
        if headerFooter == nil{
            headerFooter = T.headerFooterForNib(aClass: T.self)
        }
        return headerFooter as? T
    }
    
    func registerNib<T: UITableViewCell>(from nib: T.Type) -> Void {
        let identifier = String(describing: nib)
        self.register(UINib.init(nibName: identifier,
                                 bundle: Bundle.main),
                      forCellReuseIdentifier: identifier)
    }
    
    /// 快速创建并添加TableView
    /// - Parameters:
    ///   - targetVC: <#targetVC description#>
    ///   - backColor: <#backColor description#>
    ///   - rowHeight: <#rowHeight description#>
    /// - Returns: <#description#>
    @discardableResult
    static func createGroupTabAddFor(targetVC: UIViewController?, backColor: UIColor? = .systemGroupedBackground, rowHeight: CGFloat? = UITableView.automaticDimension, mj_headerBlock: MJRefreshComponentAction?, mj_footerBlock: MJRefreshComponentAction?) -> UITableView{
       
        return UITableView.createTab(targetVC: targetVC, backColor: backColor, rowHeight: rowHeight, mj_headerBlock: mj_headerBlock, mj_footerBlock: mj_footerBlock, style: .grouped)
    }
    @discardableResult
    static func createPlainTabAddFor(targetVC: UIViewController?, backColor: UIColor? = .systemGroupedBackground, rowHeigit: CGFloat? = UITableView.automaticDimension, mj_headerBlock: MJRefreshComponentAction?, mj_footerBlock: MJRefreshComponentAction?) -> UITableView{
        
        return UITableView.createTab(targetVC: targetVC, backColor: backColor, rowHeight: rowHeigit, mj_headerBlock: mj_headerBlock, mj_footerBlock: mj_footerBlock, style: .plain)
    }
    
    fileprivate static func createTab(targetVC: UIViewController?, backColor: UIColor?, rowHeight: CGFloat?, mj_headerBlock: MJRefreshComponentAction?, mj_footerBlock: MJRefreshComponentAction?, style: UITableView.Style) -> UITableView{
        let tableView = UITableView.init(frame: CGRect.zero, style: style)
        targetVC?.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        tableView.separatorStyle = .none
        tableView.rowHeight = rowHeight!
        tableView.estimatedRowHeight = 45
        tableView.backgroundColor = backColor
        tableView.delegate = targetVC as? UITableViewDelegate
        tableView.dataSource = targetVC as? UITableViewDataSource
        
//        tableView.allowsSelection = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        if mj_headerBlock != nil{
            tableView.mj_header = RefreshHeader.init(refreshingBlock: mj_headerBlock!)
        }
        if mj_footerBlock != nil{
            tableView.mj_footer = RefreshFooter.init(refreshingBlock: mj_footerBlock!)
        }
        
        return tableView
    }
    
    func wx_endRefreshing(){
        if let header = self.mj_header{
            header.endRefreshing()
        }
        if let footer = self.mj_footer{
            footer.endRefreshing()
        }
        
    }
//    func wx_add_mj_header(){
//
//        self.mj_header = RefreshHeader(refreshingBlock: {
//            if let vc = self.delegate as? BaseViewController{
//                vc.wxHttpCompleteBlock = { isSuc, res, err in
//
//                    if self.emptyDataSetSource == nil{
//                        self.emptyDataSetSource = vc
//                        self.emptyDataSetDelegate = vc
//                    }
//
//                    self.wx_endRefreshing()
//                    self.setFooterStatus()
//                    if isSuc{
//                        self.reloadData()
//                    }
//
//                }
//                vc.pageNumber = 1
//                vc.wx_getData(isFooterAdd: false)
//            }
//        })
//    }
//    func wx_add_mj_footer(){
//        self.mj_footer = RefreshFooter(refreshingBlock: {
//            if let vc = self.delegate as? BaseViewController{
//                vc.wxHttpCompleteBlock = { isSuc, res, err in
//                    self.wx_endRefreshing()
//                    self.setFooterStatus()
//                    if isSuc{
//                        self.reloadData()
//                    }
//                }
//                if vc.pageNumber <= vc.totalPage {
//                    vc.pageNumber += 1
//                    vc.wx_getData(isFooterAdd: true)
//                }
//            }
//        })
//    }
//    fileprivate func setFooterStatus(){
//        if let vc = self.delegate as? BaseViewController, vc.pageNumber >= vc.totalPage{
//            self.mj_footer?.endRefreshingWithNoMoreData()
//        }
//    }
}

class RefreshFooter: MJRefreshBackFooter {
    /**
     * 重写父类prepare方法
     * 做一个初始化配置，比如添加子控件
     */
    override func prepare() {
        super.prepare()
        mj_h = 50
        addSubview(refreshStatusLabel)
        addSubview(refreshImageView)
    }
    
    override var state: MJRefreshState {
        
        didSet {
            switch state {
            case .idle:
                refreshImageView.isHidden = false
                stopAnimation()
                refreshStatusLabel.text = "准备加载"
            case .pulling:
                refreshImageView.isHidden = true
                refreshStatusLabel.text = "松开加载更多"
            case .refreshing:
                refreshImageView.isHidden = false
                startLoadingAnimation()
                refreshStatusLabel.text = "加载中..."
            case .noMoreData:
                refreshImageView.isHidden = true
                refreshStatusLabel.text = "暂无更多数据"
            default:
                break
            }
        }
    }
    /**
     * 在这里设置子控件的位置和尺寸
     */
    override func placeSubviews() {
        super.placeSubviews()
        
        refreshStatusLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        refreshImageView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        refreshImageView.center = CGPoint(x: refreshStatusLabel.frame.midX - 50, y: mj_h * 0.5)
    }
    
    override func scrollViewContentOffsetDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentOffsetDidChange(change)
    }
    
    override func scrollViewContentSizeDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentSizeDidChange(change)
    }
    
    override func scrollViewPanStateDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewPanStateDidChange(change)
    }
    
    func  startLoadingAnimation() {
        let animainton : CABasicAnimation = CABasicAnimation()
        animainton.keyPath = "transform.rotation"
        animainton.duration = 1.0
        animainton.toValue = -Double.pi
        animainton.toValue = -Double.pi * 2
        animainton.repeatCount = MAXFLOAT
        refreshImageView.layer.add(animainton, forKey: "footerLoadingAnimation")
    }
    
    func stopAnimation() {
        refreshImageView.layer.removeAnimation(forKey: "footerLoadingAnimation")
    }
    
    //MARK: 懒加载
    lazy var refreshStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    lazy var refreshImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "Refresh_footer")
        return imageView
    }()

}

class RefreshHeader: MJRefreshNormalHeader {
    /**
     * 重写父类prepare方法
     * 做一个初始化配置，比如添加子控件
     */
    override func prepare() {
        super.prepare()
        // 设置高度
        mj_h = 80
        lastUpdatedTimeLabel?.isHidden = true
        arrowView?.image = UIImage(named: "下拉刷新向下")
    }
    override var state: MJRefreshState {
        didSet {
            switch state {
            case .idle:
                stateLabel?.text = "下拉刷新"
            case .willRefresh:
                stateLabel?.text = "即将刷新"
            case .pulling:
                stateLabel?.text = "松开刷新"
            case .refreshing:
                stateLabel?.text = "加载中"
            default:
                break
            }
        }
    }
}



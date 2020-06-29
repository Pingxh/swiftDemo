//
//  CountdownView.swift
//  Demo
//
//  Created by Apple on 2020/5/21.
//  Copyright © 2020 Yioks. All rights reserved.
//

import UIKit

//typealias scrollViewDidScroll = () -> ()
typealias ScrollViewDidScrollBlock = (_ scrollView : UIScrollView) -> Void

class CountdownView: UIView {
    
    var scrollViewDidScrollBlock: ScrollViewDidScrollBlock!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        xh_setupUI()
        xh_makeSubviewsContraint()
        
        mainScrollView.contentSize = CGSize(width: self.frame.width, height: self.frame.height * 3)
        
    }
    
    func xh_setupUI() {
        addSubview(mainScrollView)
        mainScrollView.addSubview(topView)
        mainScrollView.addSubview(bottomView)
        mainScrollView.addSubview(tableview)
        topView.addSubview(pushBtn)
    }
    
    func xh_makeSubviewsContraint() {
        
        mainScrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        topView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(mainScrollView)
            make.height.equalTo(topView.snp_width).multipliedBy(0.4)
        }
        tableview.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(topView.snp_bottom)
            make.height.equalTo(20)
        }
        pushBtn.snp.makeConstraints { (make) in
            make.center.equalTo(self.topView)
        }
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(tableview.snp_bottom)
            make.left.right.equalTo(self)
            make.bottom.equalTo(self.mainScrollView)
            make.height.equalTo(50)
        }
        self.layoutIfNeeded()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            tableview.snp.updateConstraints { (make) in
                make.height.equalTo(tableview.contentSize.height)
            }
            tableview.layoutIfNeeded()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var mainScrollView : UIScrollView = {
        let scrollview = UIScrollView.init(frame: self.bounds)
        scrollview.backgroundColor = .hexColor("87CEFA")
        scrollview.delegate = self
        return scrollview
    }()
    
    lazy var topView: UIView = {
        let topView = UIView.init()
        topView.backgroundColor = UIColor.brown
        return topView
    }()

    lazy var pushBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("push 下一页", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    
    lazy var bottomView : UIView = {
        let bottomView = UIView.init()
        bottomView.backgroundColor = UIColor.green
        return bottomView
    }()
    
    lazy var tableview: CustomTableView = {
        let tableview = CustomTableView.init(frame: .zero, style: .plain)
        tableview.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        return tableview
    }()

}

// MARK: - Scroll view delegate
extension CountdownView : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.scrollViewDidScrollBlock != nil {
            self.scrollViewDidScrollBlock(scrollView)
        }
    }
}

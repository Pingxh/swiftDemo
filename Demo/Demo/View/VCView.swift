//
//  VCView.swift
//  Demo
//
//  Created by Apple on 2020/1/8.
//  Copyright © 2020 Yioks. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveSwift

class VCView: UIView {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    
//        xh_setupUI()
//        xh_makeSubviewsConstraint()
        
    }
    
    func xh_setupUI() {
        addSubview(pushBtn)
    }
    
    func xh_makeSubviewsConstraint() {
        pushBtn.snp_makeConstraints { (make) in
            make.center.equalTo(self)
//            make.width.equalTo(self).multipliedBy(0.3)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    lazy var pushBtn :XHButton = {
        let btn = XHButton(frame: CGRect.zero, imageName: "index_1", title: "下一步", style: ButtonStyle.onlyImage)
        btn.backgroundColor = .orange
        return btn
    }()

}

extension VCView {
    

}

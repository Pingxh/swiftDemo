//
//  XHButton.swift
//  Demo
//
//  Created by Apple on 2020/1/14.
//  Copyright © 2020 Yioks. All rights reserved.
//

import UIKit

enum ButtonStyle {
    case normal
    case imageLeft
    case imageRight
    case onlyImage
    case onlyText
}

class XHButton: UIView {
    
    var imageName: String?
    var title: String?
    var style: ButtonStyle?
    
    var _target: AnyObject?
    var _action: Selector?
    
    init(frame: CGRect, imageName: String? , title: String?, style: ButtonStyle) {
        
        super.init(frame: frame)
        
        self.imageName = imageName
        self.title = title
        self.style = style
        
        self.backgroundColor = .white
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        xh_setupUI()
        xh_makeSubviewsConstraint()

    }
    
    // MARK: - 布局
    func xh_setupUI() {
        addSubview(self.bgview)
        self.bgview.addSubview(self.imageView)
        self.bgview.addSubview(self.titleLabel)
        
        if self.imageName != nil {
            self.imageView.image = UIImage.init(named: self.imageName!)
        }
        if self.title != nil {        
            self.titleLabel.text = self.title!
        }
    }
    
    func xh_makeSubviewsConstraint() {
        
        self.bgview.frame = self.bounds
        switch self.style {
        case .normal:
            self.imageView.frame = CGRect(x: 0, y: 0, width: self.bgview.frame.size.height * 0.6, height: self.bgview.frame.size.height * 0.6)
            var imgCenter = self.bgview.center
            imgCenter.y = self.bgview.frame.size.height * 0.35
            self.imageView.center = imgCenter
            self.titleLabel.textAlignment = .center
            self.titleLabel.frame = CGRect(x: 5, y: self.imageView.frame.maxY, width: self.bgview.frame.size.width - 10, height: self.bgview.frame.size.height - self.imageView.frame.maxY)
            break
        case .imageLeft:
            self.imageView.frame = CGRect(x: 0, y: 0, width: self.bgview.frame.size.height, height: self.bgview.frame.size.height)
            self.titleLabel.textAlignment = .left
            self.titleLabel.frame = CGRect(x: self.imageView.frame.maxX + 5, y: 0, width: self.bgview.frame.size.width - (self.imageView.frame.maxX + 5), height: self.bgview.frame.size.height)
            break
        case .imageRight:
            self.imageView.frame = CGRect(x: self.bgview.frame.size.width - self.bgview.frame.size.height, y: 0, width: self.bgview.frame.size.height, height: self.bgview.frame.size.height)
            self.titleLabel.textAlignment = .right
            self.titleLabel.frame = CGRect(x: 0, y: 0, width: self.bgview.frame.size.width - self.imageView.frame.size.width, height: self.bgview.frame.size.height)
            break
        case .onlyImage:
            self.imageView.frame = self.bgview.bounds
            break
        case .onlyText:
            self.titleLabel.textAlignment = .center
            self.titleLabel.frame = self.bgview.bounds
            break
        default:
            break
        }
    }
    
    func addTarget(target: Any?, action:Selector) {
        _target = target as AnyObject?
        _action = action
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.method(for: _action)
        let result = _target!.perform(_action!, with:self)
//        print(result!)
    }
    
    
// MARK: - 懒加载
    lazy var imageView: UIImageView = {
        let imgView = UIImageView.init()
        imgView.contentMode = .scaleAspectFit
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel.init()
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        return titleLabel
    }()
    
    lazy var bgview: UIView = {
        let view = UIView.init()
        view.isUserInteractionEnabled = true
        return view
    }()
    
}

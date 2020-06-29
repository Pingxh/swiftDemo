//
//  CustomTextField.swift
//  Demo
//
//  Created by Apple on 2020/5/26.
//  Copyright © 2020 Yioks. All rights reserved.
//

import UIKit

enum LineType {
    case underline
    case edgeLine
}



class CustomTextField: UITextField {
    
    let margin: CGFloat = 15.0  // 左右边距
    let viewMargin : CGFloat = 5.0  // 左右视图间距
    var _lineType : LineType = .underline
    var lineType : LineType {
        get {
            return _lineType
        }
        set {
            _lineType = newValue
            switch _lineType {
            case .underline:
                xh_setupUI()
                xh_makeSubviewsContraint()
                break
            case .edgeLine:
                self.layer.borderWidth = 0.5
                break
            default:
                break
                
            }
        }
    }
    
    var _lineBackgroundColor: UIColor = UIColor.hexColor("d3d3d3")
    var lineBackgroundColor: UIColor {
        get {
            return _lineBackgroundColor
        }
        set {
            _lineBackgroundColor = newValue
            self.layer.borderColor = _lineBackgroundColor.cgColor
            
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        
        
    }
    
    func xh_setupUI() {
        addSubview(lineView)
    }
    
    func xh_makeSubviewsContraint() {
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.bottom.equalTo(self).offset(-1)
            make.height.equalTo(1)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.lineType == .edgeLine {
            self.layer.cornerRadius = frame.size.height/2.0
        }
    }
    
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: margin, y: bounds.origin.y, width: (leftView?.frame.size.width)!, height: bounds.size.height)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x:bounds.size.width - (rightView?.frame.size.width)! - margin, y: bounds.origin.y, width: (rightView?.frame.size.width)!, height: bounds.size.height)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        if (leftView != nil && rightView != nil) {
            return CGRect(x: (leftView?.frame.maxX)! + viewMargin, y: bounds.origin.y, width: bounds.size.width - (rightView?.frame.size.width)! - (leftView?.frame.maxX)! - margin - viewMargin * 2 , height: bounds.size.height)
        }  else if (leftView != nil) {
            return CGRect(x: (leftView?.frame.maxX)! + viewMargin, y: bounds.origin.y, width: bounds.size.width - (leftView?.frame.maxX)! - margin , height: bounds.size.height)
        } else if (rightView != nil) {
            return CGRect(x: margin, y: bounds.origin.y, width: bounds.size.width - (rightView?.frame.size.width)! - margin*2 - viewMargin*2, height: bounds.size.height)
        } else {
            
            return CGRect(x: margin, y: bounds.origin.y, width: bounds.size.width - margin, height: bounds.size.height)
        }
        
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        if (leftView != nil && rightView != nil) {
            return CGRect(x: (leftView?.frame.maxX)! + viewMargin, y: bounds.origin.y, width:bounds.size.width - (rightView?.frame.size.width)! - (leftView?.frame.maxX)! - margin - viewMargin * 2, height: bounds.size.height)
        } else if (leftView != nil) {
            return CGRect(x: (leftView?.frame.maxX)! + viewMargin, y: bounds.origin.y, width: bounds.size.width - (leftView?.frame.maxX)! - margin , height: bounds.size.height)
        } else if (rightView != nil) {
            return CGRect(x: margin, y: bounds.origin.y, width: bounds.size.width - (rightView?.frame.size.width)! - margin*2 - viewMargin*2, height: bounds.size.height)
        } else {
            
            return CGRect(x: margin, y: bounds.origin.y, width: bounds.size.width - margin, height: bounds.size.height)
        }
    }
    
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if (leftView != nil && rightView != nil) {
            return CGRect(x: (leftView?.frame.maxX)! + viewMargin, y: bounds.origin.y, width:bounds.size.width - (rightView?.frame.size.width)! - (leftView?.frame.maxX)! - margin - viewMargin * 2, height: bounds.size.height)
        } else if (leftView != nil) {
            return CGRect(x: (leftView?.frame.maxX)! + viewMargin, y: bounds.origin.y, width: bounds.size.width - (leftView?.frame.maxX)! - margin , height: bounds.size.height)
        } else if (rightView != nil) {
            return CGRect(x: margin, y: bounds.origin.y, width: bounds.size.width - (rightView?.frame.size.width)! - margin*2 - viewMargin*2 , height: bounds.size.height)
        } else {
            
            return CGRect(x: margin, y: bounds.origin.y, width: bounds.size.width - margin, height: bounds.size.height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var lineView: UIView = {
        
        let lineView = UIView.init()
        lineView.backgroundColor = UIColor.hexColor("d3d3d3")
        return lineView
    }()
    
}

extension UITextField : UITextFieldDelegate {
    
    
}

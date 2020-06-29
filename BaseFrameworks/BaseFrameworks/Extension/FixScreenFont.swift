//
//  UILabelFixScreenFont.swift
//  Demo
//
//  Created by Apple on 2020/5/26.
//  Copyright © 2020 Yioks. All rights reserved.
//


import Foundation
import UIKit

/// 字体适配计算
///
/// - Parameter value: <#width description#>
/// - Returns: <#return value description#>
func fitFont(_ value: CGFloat) -> CGFloat {
    return value * UIScreen.main.bounds.size.width / 414.0
}

extension UILabel {
    
    /// xib 适配字体大小
    @IBInspectable var fixWidthScreenFont: CGFloat {
        get {
            return self.fixWidthScreenFont
        }
        set {
            if newValue > 0 {
                self.font = UIFont.init(name: self.font.fontName, size: fitFont(newValue))
            }
        }
    }
    
    
}

extension UITextView {
    /// xib 适配字体大小
    @IBInspectable var fixWidthScreenFont: CGFloat {
        get {
            return self.fixWidthScreenFont
        }
        set {
            if newValue > 0 {
                self.font = UIFont.init(name: self.font!.fontName, size: fitFont(newValue))
            }
        }
    }
}


extension UITextField {
    /// xib 适配字体大小
    @IBInspectable var fixWidthScreenFont: CGFloat {
        get {
            return self.fixWidthScreenFont
        }
        set {
            if newValue > 0 {
                self.font = UIFont.init(name: self.font!.fontName, size: fitFont(newValue))
            }
        }
    }
}

extension UIFont {
    
    class func pingFangSCRegular(_ font: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Regular", size: fitFont(font))!
    }
    
    class func pingFangSCMedium(_ font: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Medium", size: fitFont(font))!
    }
    
    class func pingFangSCLight(_ font: CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Light", size: fitFont(font))!
    }
    
    
}

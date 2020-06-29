//
//  UIView+Extension.swift
//  BaseFrameworks
//
//  Created by Apple on 2019/11/11.
//  Copyright © 2019 Pxh. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    public func setX(_ x: CGFloat) {
        var frame = self.frame
        frame.origin.x = x
        self.frame = frame
    }
    
    public func x() -> CGFloat
    {
        return self.frame.origin.x
    }
    
    public func setY(_ y: CGFloat) {
        var frame = self.frame
        frame.origin.y = y
        self.frame = frame
    }
    
    public func y() -> CGFloat {
        return self.frame.origin.y
    }
    
    public func setCenterY(_ centerY: CGFloat) {
        var center = self.center
        center.y = centerY
        self.center = center
    }
    
    public func centerY() -> CGFloat{
        return self.center.y
    }
    
    
    /// 判断一个控件是否显示在主窗口
    ///
    /// - Returns: <#return value description#>
    public func isShowOnKeyWindow() -> Bool {
        let keyWindow = UIApplication.shared.keyWindow;
        let newFrame = keyWindow?.convert(self.frame, to: self.superview)
        let winBounds = (keyWindow?.bounds)!
        let intersects = newFrame?.intersects(winBounds)
        return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects!
    }
    
    /// 切任意圆角
    ///
    /// - Parameters:
    ///   - value: 圆角的大小
    ///   - rectCorners: 圆角位置
    public func conerRadius(_ value: CGFloat, rectCorners: UIRectCorner) {
        self.layoutIfNeeded()
        let path = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: rectCorners, cornerRadii: CGSize(width: value, height: value))
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer
    }
    
}

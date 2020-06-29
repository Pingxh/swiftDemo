//
//  UIColor+Extension.swift
//  BaseFrameworks
//
//  Created by Apple on 2019/11/13.
//  Copyright © 2019 Pxh. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    /**
     快速构建rgb颜色
     
     - parameter r: r
     - parameter g: g
     - parameter b: b
     
     - returns: 返回rgb颜色对象，alpha默认1
     */
    
    public convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    public convenience init(r : CGFloat, g : CGFloat, b : CGFloat, a: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    public static func hexColor(_ color: String) -> UIColor {
        return hexColor(color, alpha: 1.0)
    }
    
    public static func hexColor(_ color: String, alpha: CGFloat) -> UIColor {
        let hexString = color.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        return UIColor(displayP3Red: red, green: green, blue: blue, alpha: alpha)
        
    }
    
    /// UIColor转UIImage
    public static  func colorToImage(color: UIColor, size: CGSize) -> UIImage {
        
        let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context?.fill(rect)
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return colorImage!
    }
    
}


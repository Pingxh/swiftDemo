//
//  UIImageView+Extension.swift
//  BaseFrameworks
//
//  Created by Apple on 2019/11/18.
//  Copyright © 2019 Pxh. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    // MARK: - 占位图
    /// 设置占位图片
    ///
    /// - Parameters:
    ///   - size: 占位图尺寸
    ///   - imageNamed: 占位图片名
    ///   - color: 背景色
    /// - Returns: <#return value description#>
    public static func placeholderImage(toSize size: CGSize, imageNamed: String, bgColor color: UIColor?) -> UIImage! {
        var 背景色 = UIColor()
        if (color != nil) {
            背景色 = color!
        } else {
            背景色 = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        }
        let image = UIImage.init(named: imageNamed)
        let logoWH = (size.width > size.height ? size.height : size.width) * 0.5
        let logoSize = CGSize(width: logoWH, height: logoWH)
        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale)
        背景色.set()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let imageX = (size.width / 2) - (logoSize.width / 2)
        let imageY = (size.height / 2) - (logoSize.height / 2)
        image?.draw(in: CGRect(x: imageX, y: imageY, width: logoSize.width, height: logoSize.height))
        let restoreImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return restoreImage
    }
    
    
    /// 颜色转换为图片
    ///
    /// - Parameter color: UIColor
    /// - Returns: UIImage 图片
    public static func colorToImage(toColor color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage!
    }
    
    /// 将图片缩放到指定大小
    ///
    /// - Parameter size: CGSize
    /// - Returns: 缩放后的图片
    public func imageScale(toSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let scaleImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaleImg!
    }
    
    
    /// 生成二维码
    /// - Parameters:
    ///   - string: 二维码字符串
    ///   - logoImg: 二维码中间的图片
    public func generateQRCode(_ string: String, logoImg: UIImage?) -> UIImage {
        
        let filter = CIFilter.init(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        let infoData = string.data(using: .utf8)
        filter?.setValue(infoData, forKey: "inputMessage")
        // 生成二维码
        if let outImage = filter?.outputImage {
            // 生成清晰的二维码
            let qrCodeImage = hightDefinitionUIImage(from: outImage, size: 300)
            // 如果有logo，将logo加入到二维码的中间
            if var image = logoImg {
                // logo 添加白色边框
                image = circleImageWithImage(image, borderWidth: 20, borderColor: UIColor.white)
                // 合成图片
                let newImage = syntheticImage(qrCodeImage, iconImage: image, width: qrCodeImage.size.width * 0.4, height: qrCodeImage.size.width * 0.4)
                return newImage
            }
            return qrCodeImage
        }
        
        return UIImage.init()
    }
    
    /// 生成高清的UIImage
    /// - Parameters:
    ///   - image: <#image description#>
    ///   - size: <#size description#>
    func hightDefinitionUIImage(from image: CIImage, size: CGFloat) -> UIImage {
        let integral = image.extent.integral
        let proportion: CGFloat = min(size/integral.width, size/integral.height)
        
        let width = integral.width * proportion
        let height = integral.height * proportion
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImage = context.createCGImage(image, from: integral)!
        
        bitmapRef.interpolationQuality = CGInterpolationQuality.none
        bitmapRef.scaleBy(x: proportion, y: proportion);
        bitmapRef.draw(bitmapImage, in: integral);
        let image: CGImage = bitmapRef.makeImage()!
        return UIImage(cgImage: image)
    }
        
    ///  二维码添加logo/头像
    /// - Parameters:
    ///   - image: 二维码
    ///   - iconImage: logo图片
    ///   - width: <#width description#>
    ///   - height: <#height description#>
    func syntheticImage(_ image: UIImage, iconImage:UIImage, width: CGFloat, height: CGFloat) -> UIImage{
        //开启图片上下文
        UIGraphicsBeginImageContext(image.size)
        //绘制背景图片
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let x = (image.size.width - width) * 0.5
        let y = (image.size.height - height) * 0.5
        iconImage.draw(in: CGRect(x: x, y: y, width: width, height: height))
        //取出绘制好的图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        //返回合成好的图片
        if let newImage = newImage {
            return newImage
        }
        return UIImage()
    }
        
    /// 二维码logo生成边框
    /// - Parameters:
    ///   - sourceImage: <#sourceImage description#>
    ///   - borderWidth: <#borderWidth description#>
    ///   - borderColor: <#borderColor description#>
    func circleImageWithImage(_ sourceImage: UIImage, borderWidth: CGFloat, borderColor: UIColor) -> UIImage {
        let imageWidth = sourceImage.size.width + 2 * borderWidth
        let imageHeight = sourceImage.size.height + 2 * borderWidth
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: imageWidth, height: imageHeight), false, 0.0)
        UIGraphicsGetCurrentContext()
        
        let radius = (sourceImage.size.width < sourceImage.size.height ? sourceImage.size.width:sourceImage.size.height) * 0.5
        let bezierPath = UIBezierPath(arcCenter: CGPoint(x: imageWidth * 0.5, y: imageHeight * 0.5), radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        bezierPath.lineWidth = borderWidth
        borderColor.setStroke()
        bezierPath.stroke()
        bezierPath.addClip()
        sourceImage.draw(in: CGRect(x: borderWidth, y: borderWidth, width: sourceImage.size.width, height: sourceImage.size.height))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }

    
}

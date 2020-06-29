//
//  NSObject+Extension.swift
//  BaseFrameworks
//
//  Created by Apple on 2019/11/16.
//  Copyright © 2019 Pxh. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    
    /// 加载 Nib 视图
    ///
    /// - Parameters:
    ///   - nibName: <#nibName description#>
    ///   - view: <#view description#>
    /// - Returns: <#return value description#>
    public func loadNib(_ nibName: String, view: UIView?) -> AnyObject {
        var view = view
        let nibContents = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)
        view = nibContents?.last as? UIView
        return view!
    }
    
    // MARK: - 归档处理
    /// 归档信息
    ///
    /// - Parameters:
    ///   - obj: 归档对象
    ///   - key: 归档key
    /// - Returns: ture 成功  false 失败
    public func keyedArchiver(_ obj: Any?, key: String) -> Bool {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver.init(forWritingWith: data)
        archiver.encode(obj, forKey: key)
        archiver.finishEncoding()
        let file = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last?.appending("/\(key).data")
        return data.write(toFile: file!, atomically: true)
    }
    
    /// 解档信息
    ///
    /// - Parameter key: 解档key
    /// - Returns: ture 成功  false：文件不存在 / 失败
    public func keyedUnarcher(_ key: String) -> Any? {
        let file = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last?.appending("/\(key).data")
        let manager = FileManager.init()
        // 文件路径不存在， 返回 falses
        guard manager.fileExists(atPath: file!) else {
            return false
        }
        
        let data = NSData.init(contentsOfFile: file!)! as Data
        let unarcher = NSKeyedUnarchiver.init(forReadingWith: data)
        return unarcher.decodeObject(forKey: key) as Any
    }
    
    /// 删除指定的归档文件
    ///
    /// - Parameter fileName: 文件名
    public func deleteKeyedArcher(_ fileName: String) {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last?.appending("/\(fileName).data")
        let manager = FileManager.init()
//        let filePath = URL(fileURLWithPath: path!).appendingPathComponent(fileName).absoluteString
        let isExist = manager.fileExists(atPath: path!)
        if isExist {
            do {
                try manager.removeItem(atPath: path!)
            } catch let error {
                print(error)
            }
        }
    }
    
    /// 删除归档文件
    public func deleteKeyedArchiverFile() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last
        let manager = FileManager.init()
        let isExist = manager.fileExists(atPath: path!)
        if isExist {
            do {
                try manager.removeItem(atPath: path!)
            } catch let error {
                print(error)
            }
        }
    }
    
    
    // MARK: - 判断图片 Url 是否包含 http:// https://
    ///  判断图片 Url 是否包含 http:// https://
    ///
    /// - Parameters:
    ///   - urlStr: <#urlStr description#>
    ///   - server: <#server description#>
    /// - Returns: <#return value description#>
    public func imageUrlHander(_ urlStr: String, server: String) -> String {
        if urlStr.contains("http://") ||
            urlStr.contains("https://"){
            return urlStr
        } else {
            return String.init(format: "\(server)\(urlStr)")
        }
    }
    
    /// 渐变色
    ///
    /// - Parameters:
    ///   - colorAry: 颜色数组 cgColor
    ///   - view: 渐变view
    /// - Returns: 渐变layer CAGradientLayer
    public func gradualLayer(forColorArray colorAry: Array<Any>, bgView: UIView?, view: Any?) {
        gradualLayer(forColorArray: colorAry, bgView: bgView, view: view, startPoint: nil, endPoint: nil, locations: nil)
    }
    
    /// 渐变色
    ///
    /// - Parameters:
    ///   - colorAry: 颜色数组 cgColor
    ///   - view: 渐变view
    ///   - locations: 渐变区域
    /// - Returns: 渐变layer CAGradientLayer
    public func gradualLayer(forColorArray colorAry: Array<Any>, bgView: UIView?, view: Any?, locations: Array<Any>?) {
        gradualLayer(forColorArray: colorAry, bgView: bgView, view: view, startPoint: nil, endPoint: nil, locations: locations)
    }
    
    /// 渐变色
    ///
    ///
    /// 渐变文字 要添加到 控件 的 父视图 上  superView.layer.insertSublayer(gradLayer, at: 0)
    ///
    /// - Parameters:
    ///   - colorAry: 颜色数组 cgColor
    ///   - view: 渐变view
    ///   - startPoint: 开始 Point
    ///   - endPoint: 结束 Point
    ///   - locations: 渐变区域
    /// - Returns: 渐变layer CAGradientLayer
    public func gradualLayer(forColorArray colorAry: Array<Any>, bgView: UIView?, view: Any?, startPoint: CGPoint? = nil, endPoint: CGPoint? = nil, locations: Array<Any>? = nil) {
        let gradLayer = CAGradientLayer.init()
        gradLayer.colors = colorAry
        if startPoint != nil {
            gradLayer.startPoint = startPoint!
        }
        if endPoint != nil {
            gradLayer.endPoint = endPoint!
        }
        if locations != nil {
            gradLayer.locations = (locations as! [NSNumber])
        } else {
            gradLayer.locations = [0, 1.0]
        }
        if view is UILabel {
            gradLayer.frame = (view as! UILabel).frame
            gradLayer.mask = (view as! UILabel).layer
            bgView!.layer.insertSublayer(gradLayer, at: 0)
        } else if view is UIView {
            gradLayer.frame = (view as! UIView).frame
            bgView!.layer.addSublayer(gradLayer)
        } else if view is UIImageView {
            gradLayer.frame = (view as! UIImageView).frame
            bgView!.layer.insertSublayer(gradLayer, at: 0)
        }
    
    }
        
}

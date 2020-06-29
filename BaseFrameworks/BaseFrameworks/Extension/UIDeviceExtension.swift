//
//  UIDevice+Extension.swift
//  BaseFrameworks
//
//  Created by Apple on 2019/11/13.
//  Copyright © 2019 Pxh. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {
    
    /// 获取设备信息
    ///
    /// - Returns: 设备信息
    public static func getDeviceDesciption() -> String {
        let device = UIDevice.current
        let name = device.name
        let model = device.model
        let localizeModel = device.localizedModel
        let systemName = device.systemName
        let systemVersion = device.systemVersion
        return "name: \(name), device: \(model)\(localizeModel), system: \(systemName)\(systemVersion)"
    }
    
}

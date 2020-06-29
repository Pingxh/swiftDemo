//
//  GeneralParameter.swift
//  Demo
//
//  Created by Apple on 2020/1/14.
//  Copyright © 2020 Yioks. All rights reserved.
//
// 通用基础请求参数
//
//

import UIKit

class GeneralParameter: NSObject {
    
    static func general() -> [String: Any]? {
        var parame = [String: Any]()
        parame["language"] = "cn"
        parame["device_type"] = "2"
        parame["_t"] = Date.dateToTimestamp(Date(), isMilli: false)
        return parame
    }

}

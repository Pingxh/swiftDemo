//
//  API.swift
//  Demo
//
//  Created by Apple on 2020/1/15.
//  Copyright © 2020 Yioks. All rights reserved.
//

import Foundation
import Moya

enum API {
    case banner([AnyHashable: Any])  // 轮播图
    case uploadHeader([AnyHashable: Any]?, [String])  // 上传图片
    case login([AnyHashable: Any]) // 登录
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "https://nikeapp.yioks.cn")!
    }
    
    // URL 路径
    var path: String {
        switch self {
        case .banner:
            return "/api/public/v2/get_banner_list.json"
        case .uploadHeader(_):
            return "/api/public/up_img.json"
        case .login(_):
            return "/api/public/token.json"
        }
    }
    
    //请求header添加参数
    var headers: [String : String]? {
        return [
            "Content-Type":"application/json",
            "version":"1.0.0"
        ]
    }

    // 请求类型
    var method: Moya.Method {
        switch self {
        case .banner(_), .login(_):
            return .get
        case .uploadHeader(_, _):
            return .post
        default:
            return .post
        }
    }
    
    // 单元测试
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    // 请求任务
    var task: Task {
        switch self {
        case .banner(let parame):
            return .requestParameters(parameters: generalParameter(parame: parame) as! [String : Any], encoding: URLEncoding.default)
        case .uploadHeader(let parame, let imageAry):
                        
            var formdataAry = [MultipartFormData]()
            for (index, image) in  imageAry.enumerated() {
                let img = UIImage(named: image)
                let data: Data = (img?.jpegData(compressionQuality: 0.5))!
                let date: Date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                var dateStr: String = formatter.string(from: date)
                dateStr = "\(dateStr)\(index).png"
                let formData = MultipartFormData(provider: .data(data), name: "image", fileName: dateStr, mimeType: "image/jpeg")
                formdataAry.append(formData)

            }
            print(formdataAry)
            return .uploadMultipart(formdataAry)
//            return .requestPlain
        case .login(let parame):
            return .requestParameters(parameters: generalParameter(parame: parame) as! [String: Any], encoding: URLEncoding.default)
        }
        
    }
    
    
    /// 通用参数拼接
    /// - Parameter parame: 参数字典
    func generalParameter(parame: [AnyHashable: Any]?) -> [AnyHashable: Any]? {
        var parameter = parame
        if parame != nil {
            for general in GeneralParameter.general()! {
                parameter![general.key] = GeneralParameter.general()![general.key]
            }
            return parameter!
        }
        return nil
    }
    
    
}


//
//  NetworkRequest.swift
//  Demo
//
//  Created by Apple on 2020/1/15.
//  Copyright © 2020 Yioks. All rights reserved.
//

import Foundation
import Moya
import Alamofire

import SwiftyJSON
import HandyJSON

/// 超时时长
private var requestTimeOut: Double = 30.0
/// 成功数据的回调
typealias successCallback = ((AnyObject) -> (Void))
/// 失败的回调
typealias failedCallback = ((String) -> (Void))
/// 网络错误的回调
typealias errorCallback = ((String) -> (Void))

private let myEndpointClosure = {(target: API) -> Endpoint in
    
    let url = target.baseURL.absoluteString + target.path
    var task = target.task
    
    var endpoint = Endpoint (
        url: url,
        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
        method: target.method,
        task: target.task,
        httpHeaderFields: target.headers
    )
    
    requestTimeOut = 30.0
    switch target {
    case .banner(_):
        return endpoint
    default:
        return endpoint
    }
    
}

/// 网络请求的设置
private let requestClosure = {(endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        request.timeoutInterval = requestTimeOut
        // 打印请求参数
        if let requestData = request.httpBody {
            print("\(String(describing: request.url)) \n \(String(describing: request.httpMethod)) \n发送参数\(String(describing: String(data: request.httpBody!, encoding: String.Encoding.utf8)))")
        } else {
            print("\(String(describing: request.url)) \n\(String(describing: request.httpMethod))")
        }
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}

/// NetworkActivityPlugin 网络监听
private let networkPlugin = NetworkActivityPlugin.init { (changeType, targetType) in
    
    switch changeType {
    case .began:
        print("开始请求网络")
    case .ended:
        print("请求结束")
    }
}

let Provider = MoyaProvider<API>(endpointClosure: myEndpointClosure, requestClosure: requestClosure, plugins: [networkPlugin], trackInflights: false)

func NetworkRequest(_ target: API, completion: @escaping successCallback) {
    NetworkRequest(target, completion: completion, failed: nil)
}

func NetworkRequest(_ target: API, completion: @escaping successCallback, failed: failedCallback?) {
    NetworkRequest(target, completion: completion, failed: failed, errorResult: nil)
}

///  需要知道成功、失败、错误情况回调的网络请求   像结束下拉刷新各种情况都要判断
///
/// - Parameters:
///   - target: 网络请求
///   - completion: 成功
///   - failed: 失败
///   - error: 错误
@discardableResult //当我们需要主动取消网络请求的时候可以用返回值Cancellable, 一般不用的话做忽略处理
func NetworkRequest(_ target: API, completion: @escaping successCallback, failed: failedCallback?, errorResult: errorCallback?) -> Cancellable? {
    if !isNetworkConnect {
        // 网络有问题
        print("网络有问题")
        
        return nil
    }
    return Provider.request(target) { (result) in
        switch result {
        case let .success(response):
            do {
                let model = BasicTypes.deserialize(from: try! response.mapString())
                if model?.status == 0 {
                    completion(model!.result!)
                } else {
                    failed!(model!.msg!)
                }
            } catch {
                failed!("数据请求失败")
            }
        case let .failure(error):
            failed!(error.errorDescription!)
        }
    }
 
}

/// 基于 Alamofire 的网络连接判断
/// 用 get 方法获取实时网络链接
var isNetworkConnect: Bool {
    get {
        let network = NetworkReachabilityManager()
        return network?.isReachable ?? true  // 无返回就默认网络已连接
    }
}

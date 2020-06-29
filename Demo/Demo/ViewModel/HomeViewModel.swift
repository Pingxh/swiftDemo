//
//  HomeViewModel.swift
//  Demo
//
//  Created by Apple on 2020/1/15.
//  Copyright © 2020 Yioks. All rights reserved.
//

import UIKit

class HomeViewModel: NSObject {
    
    func xh_requestForBanner(parame: [AnyHashable: Any]) {
        NetworkRequest(.banner(parame), completion: { (result) -> (Void) in
            
        }) { (error) -> (Void) in
            print(error)
        }
    }
    
    func xh_requestForLogin(parame: [AnyHashable: Any], success: @escaping successCallback, failed: @escaping failedCallback) {
        NetworkRequest(.login(parame), completion: { (result) -> (Void) in
                
            let model = LoginResutlMode.deserialize(from: result as? NSDictionary)
            success(model!)
            
        }) { (error) -> (Void) in
            print("错误: \(error)")
            failed(error)
        }
    }
    
    func xh_uploadFile(parame: [AnyHashable: Any]?, imageAry: [String], success: @escaping successCallback, failed: @escaping failedCallback) {
        NetworkRequest(.uploadHeader(parame, imageAry), completion: { (result) -> (Void) in
            success(result)
        }) { (error) -> (Void) in
            failed(error)
        }
    }
    

}

//
//  JSHandler.swift
//  Demo
//
//  Created by Apple on 2020/1/10.
//  Copyright © 2020 Yioks. All rights reserved.
//

import UIKit
import WebKit

enum JSHandlerType {
    case normal
    case back
}
// 定义 block
//typealias vccourse = (JSHandlerType, AnyObject?)

class JSHandler: NSObject {
    
    weak var webvc : WebViewController?
    weak var configuration: WKWebViewConfiguration?

    // 定义block
    typealias funcBlock = (String, Any?, JSHandlerType) -> ()
    // 创建block变量
    public var blockHandler: funcBlock!
    
    override init() {
        super.init()
    }
    
    init(webvc: UIViewController, configuration: WKWebViewConfiguration) {
        super.init()
        self.configuration = configuration
        self.webvc = (webvc as! WebViewController)
        // 注册 JS 方法
        configuration.userContentController.add(self, name: "backPage")
        configuration.userContentController.add(self, name: "showImages")

        print("\(configuration.userContentController.userScripts)")
    }
    
    func cancelHandler() {
        // 移除 JS 方法
        self.configuration?.userContentController.removeScriptMessageHandler(forName: "backPage")
        self.configuration?.userContentController.removeScriptMessageHandler(forName: "showImages")
    }
        
}

extension JSHandler: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        blockHandler( message.name , message.body, self.recordHandle(message.name))
    }
    
    func recordHandle(_ typeStr: String) -> JSHandlerType {
        if typeStr == "backPage" {
            return JSHandlerType.back
        } else {
            return JSHandlerType.normal
        }
                
    }
    
    
}

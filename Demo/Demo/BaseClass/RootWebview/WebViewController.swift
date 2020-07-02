//
//  WebViewController.swift
//  Demo
//
//  Created by Apple on 2020/1/10.
//  Copyright © 2020 Yioks. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: RootViewController {
    
    var _jsHandler = JSHandler()
    
    var lastProgress: Double = 0.0
    var _progressViewColor : UIColor = .red
    var progressViewColor : UIColor {
        get {
            _progressViewColor
        }
        set {
            _progressViewColor = newValue
        }
    }
    
    var _url : String?
    var _htmlStr : String?
    
    override func loadView() {
        super.loadView()
        
    }
    
    /// 重写 init
    /// - Parameter url: <#url description#>
    init(url: String) {
        super.init(nibName: nil, bundle: nil)
        _url = url
    }
    
    init(htmlPath: String) {
        super.init(nibName: nil, bundle: nil)
        do {
            let html = try String.init(contentsOfFile: htmlPath, encoding: String.Encoding.utf8)
            _htmlStr = html
        } catch let err as NSError {
            print(err.description)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        if #available(iOS 11.0, *) {
//            self.webview.scrollView.contentInsetAdjustmentBehavior = .never
//        } else {
//            self.automaticallyAdjustsScrollViewInsets = false
//        }
//        self.edgesForExtendedLayout = []
        self.view.addSubview(self.webview)
        
        
        _jsHandler.blockHandler = {(jsName, jsData, enumType) in
            switch enumType {
            case .back:
                print(jsName, jsData as Any)
                self.navigationController?.popViewController(animated: true)
            break
            case .closepage:
                print("close")
                break
            default:
                break
            }
//            if type == "backPage" {
//                print(type, msg as Any)
//                self.navigationController?.popViewController(animated: true)
//            }
        }
        
    }
    
    func updateNavigationItem() {}
    func backBtnClick() {
        self.webview.stopLoading()
        if self.webview.canGoBack {
            self.webview.goBack()
        } else {
            self.backBtnClick()
        }
    }
    
    // MARK: -
    deinit {
        self.webview.removeObserver(self, forKeyPath: "estimatedProgress")
        self.webview.removeObserver(self, forKeyPath: "canGoBack")
    }
    
    // MARK: - 监听 KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "canGoBack" {
            self.updateNavigationItem()
        }
        if keyPath == "estimatedProgress" {
            self.updateProgress(progress: self.webview.estimatedProgress)
        }
        if keyPath == "title" {
            self.navigationItem.title = self.webview.title
        }
    }

    // MARK: - 懒加载    
    lazy var webview: WKWebView = {
        let configuration = WKWebViewConfiguration.init()
        // 打开 JS 交互
        configuration.preferences.javaScriptEnabled = true
        _jsHandler = JSHandler(webvc: self, configuration: configuration)
        
        let webview = WKWebView.init(frame: self.view.bounds, configuration: configuration)
        webview.navigationDelegate = self
        webview.backgroundColor = .clear
        // 打开网页间的滑动返回
        webview.allowsBackForwardNavigationGestures = true
        webview.scrollView.decelerationRate = .normal
//        webview.scrollView.delegate = self
        let js = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        let wkUScript = WKUserScript.init(source: js, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
        let userController = WKUserContentController()
        userController.addUserScript(wkUScript)
        configuration.userContentController = userController
        
        if _url != nil {
            let request = URLRequest.init(url: URL.init(string: _url!)!)
            webview.load(request)
        }
        if _htmlStr != nil {
            webview.loadHTMLString(_htmlStr!, baseURL: nil)
        }
        
        webview.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        webview.addObserver(self, forKeyPath: "canGoBack", options: .new, context: nil)
        webview.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webview.addSubview(self.progressView)
        
        return webview
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView.init(progressViewStyle: UIProgressView.Style.default)
        progressView.tintColor = self.progressViewColor
        progressView.trackTintColor = .clear
        progressView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100.0)
        return progressView
    }()

}

// MARK: - WKNavigationDelegate
extension WebViewController: WKNavigationDelegate, UIScrollViewDelegate {
    
    /// 加载完成
    /// - Parameters:
    ///   - webView: <#webView description#>
    ///   - navigation: <#navigation description#>
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 禁止长按
        var javascript = "document.documentElement.style.webkitTouchCallout='none';"
        // 禁止选择
        javascript.append("document.documentElement.style.webkitUserSelect='none';")
        webview.evaluateJavaScript(javascript, completionHandler: nil)
        // 进度条
        self.updateProgress(progress: webView.estimatedProgress)
        // 更新返回按钮
        self.updateNavigationItem()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if webView != self.webview {
            decisionHandler(.allow)
            return
        }
        // 更新返回按钮
        self.updateNavigationItem()
        let url = webView.url
        // 打开wkwebview禁用了电话和跳转appstore，通过这个方法打开
        let app = UIApplication.shared
        if url?.scheme == "tel" {
            if app.canOpenURL(url!) {
                app.open(url!, options: [:]) { (completion) in
                }
                decisionHandler(.cancel)
                return
            }
        }
        if (url?.absoluteString.contains("itunes.apple.com"))! {
            if app.canOpenURL(url!) {
                app.open(url!, options: [:]) { (completion) in
                }
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
    }
    
    /// 更新进度条
    /// - Parameter progress: <#progress description#>
    func updateProgress(progress: Double) {
        self.progressView.alpha = 1;
        if progress > self.lastProgress {
            self.progressView.setProgress(Float(self.webview.estimatedProgress), animated: true)
        } else {
            self.progressView.setProgress(Float(self.webview.estimatedProgress), animated: true)
        }
        self.lastProgress = progress
        if progress >= 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.progressView.alpha = 0
                self.progressView.setProgress(0, animated: true)
                self.lastProgress = 0
            }
        }
    }
        
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return nil
    }
    
    
}

class LeakAvoider: NSObject {
    weak var delegate: WKScriptMessageHandler?
    
    init(delegate: WKScriptMessageHandler) {
        super.init()
        self.delegate = delegate
    }
}

extension LeakAvoider: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        delegate?.userContentController(userContentController, didReceive: message)
    }
}


//
//  RootViewController.swift
//  Demo
//
//  Created by Apple on 2020/1/8.
//  Copyright © 2020 Yioks. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    
        
    /// 是否显示返回按钮，默认 true
    public var _isShowLeftBack = true
    // MARK: - isShowLeftBack set方法
    public var isShowLeftBack : Bool {
        get {
            _isShowLeftBack
        }
        set {
            _isShowLeftBack = newValue
            if (navigationController != nil) {
                let VCCount = (navigationController?.viewControllers.count)!
                if _isShowLeftBack && (VCCount > 1 || navigationController?.presentingViewController != nil) {
                    navigationBarImageItem(["nav_back"], isLeft: true, target: self, action: #selector(backButtonDidClick), tags: [2000])
                } else {
                    navigationItem.hidesBackButton = true
                    let bar = UIBarButtonItem(customView: UIView())
                    navigationItem.leftBarButtonItem = bar
                    
                }
            }
        }
    }
    // 状态栏的样式： 黑色
    public var _statusBarStyle: UIStatusBarStyle = .default
    // MARK: - bar style set方法
    public var statusBarStyle : UIStatusBarStyle! {
        get {
            _statusBarStyle
        }
        set {
            _statusBarStyle = newValue
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }

    /// 是否隐藏导航栏
    var isHidenNavBar : Bool?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                
        // 设置导航栏配置
        hx_backgroundColor = .hexColor("FF8000")
        hx_shadowHidden = true
        hx_titleColor = .white
        
        if (navigationController != nil) {
            let VCCount = (navigationController?.viewControllers.count)!
            if  (VCCount > 1 || navigationController?.presentingViewController != nil) {
                navigationBarImageItem(["nav_back"], isLeft: true, target: self, action: #selector(backButtonDidClick), tags: [2000])
            } else {
                navigationItem.hidesBackButton = true
                let bar = UIBarButtonItem(customView: UIView())
                navigationItem.leftBarButtonItem = bar
                
            }
        }
    }
    
    
    
    // MARK: - 导航栏图片按钮
    func navigationBarImageItem(_ names: [AnyHashable]?, isLeft: Bool, target: Any?, action: Selector, tags: [AnyHashable]?) {
        var items : [AnyHashable] = []
        var i = 0
        for imageName in names! {
            let button = UIButton.init(type: .custom)
            button.tag = tags![i] as! Int
            button.setImage(UIImage.init(named: imageName as! String), for: .normal)
            button.addTarget(self, action: action, for: .touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: 30.0, height: 30.0)
            let barItem = UIBarButtonItem.init(customView: button)
            items.append(barItem)
            i+=1
        }
        if isLeft {
            navigationItem.leftBarButtonItems = items as? [UIBarButtonItem]
        } else {
            navigationItem.rightBarButtonItems = items as? [UIBarButtonItem]
        }
    }
    
    // MARK: - 导航栏图片按钮
    func navigationBarTitleItem(_ titles: [AnyHashable]?, isLeft: Bool, target: Any?, action: Selector, tags: [AnyHashable]?) {
        var items : [AnyHashable] = []
        var i = 0
        for title in titles! {
            let button = UIButton.init(type: .custom)
            button.tag = tags![i] as! Int
            button.setTitle(title as? String, for: .normal)
            button.addTarget(self, action: action, for: .touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: 30.0, height: 30.0)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.sizeToFit()
            i+=1
            if isLeft {
                button.contentEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
            } else {
                button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
            }
            let barItem = UIBarButtonItem.init(customView: button)
            items.append(barItem)
            
        }
        if isLeft {
            navigationItem.leftBarButtonItems = items as? [UIBarButtonItem]
        } else {
            navigationItem.rightBarButtonItems = items as? [UIBarButtonItem]
        }
    }
    
    // MARK: 返回按钮方法
    @objc func backButtonDidClick() {
        if (self.presentingViewController != nil) {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    /// 重写状态栏style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.statusBarStyle
    }
    
    // MARK: 屏幕旋转方法重写
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return UIInterfaceOrientation.portrait
    }
    
    // MARK: - 懒加载
    lazy var loadingview: LoadingView = {
        let view = LoadingView.init(frame: self.view.bounds)
        view.delegate = self
        return view
    }()

}

extension RootViewController {
    
    /// 加载动画
    func startLoadingAnimation() {
        view.addSubview(loadingview)
        loadingview.startAnimation()
    }
    
    /// 停止加载动画
    func stopLoadingAnimation() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25, animations: {
                self.loadingview.alpha = 0.0
            }) { (finish) in
                self.loadingview.removeFromSuperview()
                self.loadingview.stopAnimation()
            }
        }
    }
    
    
}

extension RootViewController : LoadingViewProtocol {
    
    func loadingReload() {
        
    }
    
}

//
//  CountdownVC.swift
//  Demo
//
//  Created by Apple on 2020/1/8.
//  Copyright © 2020 Yioks. All rights reserved.
//

import UIKit

//@available(iOS 11.0, *)
class CountdownVC: RootViewController {
    
    var downView : CountdownView!
    
    // MARK: - life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func loadView() {
        super.loadView()
        let view = CountdownView.init(frame: self.view.bounds)
        downView = view
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "书城"
        hx_barAlpha = 0

        if #available(iOS 11.0, *) {
            downView.mainScrollView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }

        self.automaticallyAdjustsScrollViewInsets = false
        self.statusBarStyle = UIStatusBarStyle.lightContent
        
//        navigationBarTitleItem(["返回"], isLeft: true, target: self, action: #selector(back), tags: [2000])
        
        // block 传值
        downView.scrollViewDidScrollBlock = {(scrollView: UIScrollView) in
            let offsetY = scrollView.contentOffset.y
            let alpha = min(1, 1 - (64 - offsetY) / 64)
            self.hx_barAlpha = alpha
        }
        
        downView.pushBtn.reactive.controlEvents(.touchUpInside).observeValues { (sender) in
            // 获取本地路径
            let bundlePath = Bundle.main.bundlePath
            // 获取本地 html 目录
            let basePath = "\(bundlePath)/h5"
            // 获取本地 html 目录 base url
            let baseUrl = NSURL.fileURL(withPath: basePath, isDirectory: true)
            let url = "\(baseUrl)/index.html"
            let path = Bundle.main.path(forResource: "JSToOC", ofType: "html")
            let vc = RootWebViewController.init(url: url)
            self.navigationController?.pushViewController(vc, animated: true)

        }
        
        downView.tableview.dataArray = ["1", "2", "3", "2", "3", "2", "3", "2", "3", "2", "3"]
        downView.tableview.reloadData()
                
    }
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }

}

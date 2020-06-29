//
//  RootWebViewController.swift
//  Demo
//
//  Created by Apple on 2020/1/10.
//  Copyright © 2020 Yioks. All rights reserved.
//

import UIKit

class RootWebViewController: WebViewController {

    
    var isShowCloseBtn : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    override func updateNavigationItem() {
        if self.isShowCloseBtn {
            if self.webview.canGoBack {
                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
                navigationBarImageItem(["nav_back", "nav_close"], isLeft: true, target: self, action: #selector(leftButtonDidClick(sender:)), tags: [2000, 2001])
            } else {
                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
                navigationBarImageItem(["nav_back"], isLeft: true, target: self, action: #selector(leftButtonDidClick(sender:)), tags: [2001])
            }
                
        }
    }
    
    @objc func leftButtonDidClick(sender : UIButton) {
        switch sender.tag {
        case 2000:
            self.backBtnClick()
        case 2001:
            self.backButtonDidClick()
        default:
            self.backButtonDidClick()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

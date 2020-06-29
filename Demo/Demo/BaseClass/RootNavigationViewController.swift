//
//  RootNavigationViewController.swift
//  Demo
//
//  Created by Apple on 2020/1/8.
//  Copyright © 2020 Yioks. All rights reserved.
//

import UIKit

class RootNavigationViewController: HXNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.interactivePopGestureRecognizer?.delegate = nil
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }
    
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
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

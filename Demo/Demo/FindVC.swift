//
//  FindVC.swift
//  Demo
//
//  Created by Apple on 2020/1/9.
//  Copyright © 2020 Yioks. All rights reserved.
//

import UIKit

class FindVC: RootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "发现"
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
//        navigationBarTitleItem(["返回"], isLeft: true, target: self, action: #selector(back), tags: [2000])
//        navigationBarImageItem(["nav_back"], isLeft: false, target: self, action: #selector(back), tags: [2000])
        self.statusBarStyle = .lightContent
        
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.navigationController?.popViewController(animated: true)
    }
    

}

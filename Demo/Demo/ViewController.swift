//
//  ViewController.swift
//  Demo
//
//  Created by Apple on 2020/1/8.
//  Copyright © 2020 Yioks. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import MGJRouter_Swift
import Moya
//import BaseFrameworks


class ViewController: UIViewController {
    
    var vcview : VCView!
    var menuView : XHMenuScrollView!
    let viewModel = HomeViewModel()
    
    @IBOutlet weak var fontFixLabel: UILabel!
    
    override func loadView() {
        super.loadView()
        
//        let v = VCView.init(frame: self.view.bounds)
//        vcview = v
//        self.view = v
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
//        fontFixLabel.text = "测试字体大小"
//        let fix = fontFixLabel.font.pointSize
//        fontFixLabel.font = UIFont.pingFangSCLight(20)
//        fontFixLabel.text = "\(fix)"
        
        let tf = CustomTextField.init()
        tf.lineType = .edgeLine
        tf.lineBackgroundColor = UIColor.red
        tf.placeholder = "测试输入框"
        view.addSubview(tf)
        tf.margin = 5
        
        
        
//        let label = UILabel.init()
//        label.text = "右视图"
//        label.frame = CGRect.init(x: 0.0, y: 0.0, width: 80.0, height: 50)
//        label.sizeToFit()
//        tf.rightView = label
//        tf.rightViewMode = .always
        
//        let label1 = UILabel.init()
//        label1.text = "左视图"
//        label1.frame = CGRect.init(x: 0.0, y: 0.0, width: 80.0, height: 50)
//        label1.sizeToFit()
//        tf.leftView = label1
//        tf.leftViewMode = .always
        
        tf.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.8)
            make.height.equalTo(50)
        }
        
        let op = BlockOperation.init {
            print("\(Thread.current)")
            print("第一个操作")
        }
        op.addExecutionBlock {
            print("\(Thread.current)")
            print("第二个操作")
        }
        op.addExecutionBlock {
            print("\(Thread.current)")
            print("第三个操作")
        }
        op.start()
        
        let result = sum(value: 100)
        print(result)
        
        
//        self.navigationItem.title = "畅游计划"
//        self.view.backgroundColor = .white
//        self.automaticallyAdjustsScrollViewInsets = false  // 设置scrollview不自动偏移
//        let menuView = XHMenuScrollView.init(frame: CGRect(x: 0, y: 80, width: self.view.frame.size.width, height: 40.0), normalTextColor: .black, selectTextColor: .brown)
//        menuView.backgroundColor = .lightGray
//        menuView.menuDelegate = self
//        menuView.titleArray = ["推荐", "今日头条", "新闻", "智能汽车", "科技", "汽车", "智能汽车", "科技", "汽车"]
//        view.addSubview(menuView)
//        self.menuView = menuView
//        
//        view.addSubview(self.subScrollView)
//        self.subScrollView.snp.makeConstraints { (make) in
//            make.left.bottom.right.equalTo(self.view)
//            make.top.equalTo(menuView.snp_bottom)
//        }
//        self.subScrollView.contentSize = CGSize(width: screenWidth * CGFloat(menuView.titleArray.count), height: 0.0)
//
//        self.subScrollView.addSubview(vcview.pushBtn)
//        vcview.pushBtn.snp_makeConstraints { (make) in
//            make.center.equalTo(self.subScrollView)
//            make.width.equalTo(60)
//            make.height.equalTo(60)
//        }
//        vcview.pushBtn.addTarget(target: self, action: #selector(buttonDidClick(sender:)))
        
//        let item = self.navigationController?.tabBarItem
//        print(item)
//        item?.title = "Home"
        
    }
    
    func sum(value: Int) -> Int {
        if value <= 0 {
            return 0
        }
        let number = value
        return value + sum(value: number - 1)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func buttonDidClick(sender: XHButton) {
        print("按钮点击事件")
        
        
        if (UseSaveManager.readData(forUseDefalutKeyed: "token") == nil) {
            
            let loginParame: [AnyHashable: Any] = ["user_phone": "12345678901", "code": "123456", "user_type": "parent"]
            self.viewModel.xh_requestForLogin(parame: loginParame, success: { (result) -> (Void) in
                let model: LoginResutlMode = result as! LoginResutlMode
                print(model.user?.user_id! as Any)
                UseSaveManager.saveData(toData: model.user?.token, toUseDefaultKeyed: "token")
            }) { (error) -> (Void) in
                print("login : \(error)")
            }
        } else {
//            let parame: [AnyHashable: Any] = [ "area_id": "20", "module_type": "home"]

            let imageAry = ["nav_back"]
            self.viewModel.xh_uploadFile(parame: nil, imageAry: imageAry, success: { (result) -> (Void) in
                print(result["imageurl"] as Any)
            }) { (error) -> (Void) in
                print("upload : \(error)")
            }
        }
    }
    
    lazy var subScrollView : UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.bounces = true
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.menuView.changeIndicationOffset(scrollView: scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.subScrollView == scrollView {
            let index: Int = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
            let selLabel = self.menuView.titleLabelArray[index]
            
            self.menuView.titleLabelSelectedHandle(selLabel: selLabel)
            
        }
    }
    
}

extension ViewController: XHMenuDelegate {
    func menuView(menuVie: XHMenuScrollView, index: Int) {
        let offsetX: CGFloat = CGFloat(index * Int(self.view.frame.size.width))
        self.subScrollView.contentOffset = CGPoint(x: offsetX, y: 0.0)
    }
}


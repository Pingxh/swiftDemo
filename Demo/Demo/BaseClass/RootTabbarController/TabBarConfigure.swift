//
//  TabBarConfigure.swift
//  Demo
//
//  Created by Apple on 2020/1/9.
//  Copyright © 2020 Yioks. All rights reserved.
//

import UIKit

class TabBarConfigure: NSObject {
    
    public static func getTabBars() -> [RootTabBarModel] {
        
        let tabBarNormalImages = ["shelfTabar_N","shelfTabar_N","","welfare_N","acount_N"]
        let tabBarSelectedImages = ["shelfTabar_S","shelfTabar_S","","welfare_N","acount_S"]
        let tabBarTitles = ["首页","书城","","发现","我的"]
        
        let rootModel1 = RootTabBarModel.init(title: tabBarTitles[0], imageNormal: tabBarNormalImages[0], imageSelected: tabBarSelectedImages[0], controller: ViewController(), tag: 0)
        
        let rootModel12 = RootTabBarModel.init(title: tabBarTitles[1], imageNormal: tabBarNormalImages[1], imageSelected: tabBarSelectedImages[1], controller: CountdownVC(), tag: 1)
        
        let rootModel2 = RootTabBarModel.init(title: tabBarTitles[2], imageNormal: tabBarNormalImages[2], imageSelected: tabBarSelectedImages[2], controller: FindVC(), tag: 2)

        let rootModel3 = RootTabBarModel.init(title: tabBarTitles[3], imageNormal: tabBarNormalImages[3], imageSelected: tabBarSelectedImages[3], controller: MoreVC(), tag: 3)
        
        let rootModel4 = RootTabBarModel.init(title: tabBarTitles[4], imageNormal: tabBarNormalImages[4], imageSelected: tabBarSelectedImages[4], controller: MineVC(), tag: 4)
        let tabBars =  [rootModel1,rootModel12, rootModel2,rootModel3,rootModel4]
        return tabBars
    }
    
    /// 定制 tabbar 和 navgationBar 样式
    ///
    /// - Returns: RootTabBarConfig 对象
    public static func getConfigModel() -> RootTabBarConfig {
        let rootConfig = RootTabBarConfig()
        rootConfig.tabBarStyle = .center
        
        /// 是否 点击  动画
        rootConfig.isAnimation = true
        
        /// 点击 动画类型 scaleDown：小-大     rotation： 旋转
        rootConfig.animation = .scaleDown
        
        /// 中心按钮j 上浮高度
        rootConfig.centerInsetUp = 10.0
        
        rootConfig.tabBarBackgroundColor = UIColor(white: 1, alpha: 1)
        
        rootConfig.navBarBackgroundColor = UIColor(white: 0.98, alpha: 0.99)
        
        rootConfig.tabBarShadowColor = UIColor.clear
        
        rootConfig.titleColorSelected = UIColor.blue
        
        //rootConfig.centerViewController = PresentController()
        
        return rootConfig
    }

}

//
//  Bundle+Extension.swift
//  BaseFrameworks
//
//  Created by Apple on 2019/11/21.
//  Copyright © 2019 Pxh. All rights reserved.
//

import Foundation

private var BundleKey = "LanguageKey"

public class BundleEx : Bundle {
    
    public override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        let bundle: Bundle = objc_getAssociatedObject(self, &BundleKey) as! Bundle
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
    
}

extension Bundle {
    
    /// 设置当前语言
    ///
    /// - Parameter language: 当前语言的字符串形式
    public class func setLanguage(forLanguage language: String?) {
        do {
        object_setClass(Bundle.main, BundleEx.self)
        }
        let path = Bundle.init(path: Bundle.main.path(forResource: language!, ofType: "lproj")!)
        let value = (language != nil ? path : nil)
        objc_setAssociatedObject(Bundle.main, &BundleKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
}

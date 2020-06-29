//
//  Localizable.swift
//  BaseFrameworks
//
//  Created by Apple on 2019/11/21.
//  Copyright © 2019 Pxh. All rights reserved.
//

import UIKit

public let Chinese_Hans = "zh-Hans"   // 简体中文
public let Chinese_Hant = "zh-Hant"   // 繁体中文
public let English = "en"   // 英文
public let LanguageKey = "language"
public let NotificationLanguageChanged = "languageChanged"


public class Localizable: NSObject {
    static let currentLanguage = Localizable.self
    static let BundleKey = "LanguageKey"
    
    /// 初始化
    public class func initUserLanguage() {
        var language = Localizable.userLanguage()
        let hans: [String] = Localizable.chineseHans() as! [String]
        
        if hans.contains(language) {
            language = Localizable.chineseHans().first as! String
        }
        let hant: [String] = Localizable.chineseHant() as! [String]
        if hant.contains(language) {
            language = Localizable.chineseHant().first as! String
        }
        let englist: [String] = Localizable.english() as! [String]
        if englist.contains(language) {
            language = Localizable.english().first as! String
        }
        
        UserDefaults.standard.set(language, forKey: LanguageKey)
        UserDefaults.standard.synchronize()
        Bundle.setLanguage(forLanguage: language)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationLanguageChanged), object: currentLanguage)
    }
    
    public class func english() -> Array<Any> {
        return ["en", "en-CN"]
    }
    
    public class func chineseHans() -> Array<Any> {
        return ["zh-Hans", "zh-Hans-CN"]
    }
    
    public class func chineseHant() -> Array<Any> {
        return ["zh-Hant", "zh-Hant-CN"]
    }
    
    /// 获取当前语言
    ///
    /// - Returns: 当前语言
    public class func userLanguage() -> String {
        let language = UserDefaults.standard.object(forKey: LanguageKey) as? String
        if !(language != nil) {
            let languages = UserDefaults.standard.object(forKey: "AppleLanguages") as! Array<Any>
            return languages.first as! String
        }
        return language!
    }
    
    /// 设置当前语言
    ///
    /// - Parameter language: 当前语言的字符串形式
    public class func setUserLanguage(forLanguage language: String) {
        if Localizable.userLanguage() == language {
            return
        }
        UserDefaults.standard.set(language, forKey: LanguageKey)
        UserDefaults.standard.synchronize()
        Bundle.setLanguage(forLanguage: language)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationLanguageChanged), object: currentLanguage)
    }

}

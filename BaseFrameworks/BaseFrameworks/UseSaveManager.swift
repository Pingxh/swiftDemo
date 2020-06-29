//
//  UseSaveManager.swift
//  BaseFrameworks
//
//  Created by Apple on 2019/11/21.
//  Copyright © 2019 Pxh. All rights reserved.
//

import UIKit

public class UseSaveManager: NSObject {
    
    public class func saveData(toData data: Any?, toUseDefaultKeyed key: Any?) -> Bool{
        
        if !(key is String) {
            return false
        }
        
        if data == nil || data is NSNull {
            return false
        }
        
        let muDefault = UserDefaults.standard
        muDefault.set(data, forKey: key as! String)
        
        return muDefault.synchronize()
    }
    
    public class func readData(forUseDefalutKeyed key: Any?) -> Any? {
        
        if key != nil && !(key is String) {
            return nil
        }
        
        let muDefault = UserDefaults.standard
        let data = muDefault.object(forKey: key as! String)
        if data == nil || data is NSNull {
            return nil
        }
        return data as Any
    }
    
    public class func deleteData(toUserDefaultKeyed key: Any?) -> Bool {
        if !(key is String) {
            return true
        }
        let muDefault = UserDefaults.standard
        muDefault.removeObject(forKey: key as! String)
        return muDefault.synchronize()
    }
    
    public class func deleteAllUseDefaultsData() {
        let userDefaults = UserDefaults.standard
        let dic: Dictionary = userDefaults.dictionaryRepresentation()
        for (key, _) in dic {
            userDefaults.removeObject(forKey: key)
        }
        userDefaults.synchronize()
    }

}

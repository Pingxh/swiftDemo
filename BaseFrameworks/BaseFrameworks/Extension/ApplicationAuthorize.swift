//
//  ApplicationAuthorize.swift
//  Demo
//
//  Created by Apple on 2020/5/26.
//  Copyright © 2020 Yioks. All rights reserved.
//

import Foundation
import UIKit
import Photos


extension UIApplication {
    
        
    /// 相机是否授权
    /// - Returns: 已授权 true / 未授权 false
    class func isCameraAuthorized() -> Bool {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch authStatus {
        case .restricted:  // 受限制
            return false
        case .denied:  // 被拒
            return false
        case .notDetermined:  // 还未决定
            return false
        case .authorized:  // 授权
            return true
        default:
            return false
        }
    }
    
    
    /// 麦克风是否授权
    /// - Returns: 已授权 true / 未授权 false
    class func isMicorphoneAuthorized() -> Bool {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .audio)
        switch authStatus {
        case .restricted:  // 受限制
            return false
        case .denied:  // 被拒
            return false
        case .notDetermined:  // 还未决定
            return false
        case .authorized:  // 授权
            return true
        default:
            return false
        }
    }
    
    /// 相册是否授权
    /// - Returns: 已授权 true / 未授权 false
    class func isAlbumAuthorized() -> Bool {
        let author = PHPhotoLibrary.authorizationStatus()
        switch author {
        case .restricted:  // 受限制
            return false
        case .denied:  // 被拒
            return false
        case .notDetermined:  // 还未决定
            return false
        case .authorized:  // 授权
            return true
        default:
            return false
        }
    }
    
    
}

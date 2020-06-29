//
//  DataExtension.swift
//  Demo
//
//  Created by Apple on 2020/5/26.
//  Copyright © 2020 Yioks. All rights reserved.
//

import Foundation
import CommonCrypto

extension Data {
    
    /// Data MD5
    public var dataMD5: String {
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        _ = withUnsafeBytes { (bytes) in
            CC_MD5(bytes, CC_LONG(count), &digest)
        }
        var digestHex = ""
        for index in 0 ..< Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        return digestHex
    }
    
    
}

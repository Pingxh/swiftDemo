//
//  NSString+Extension.swift
//  BaseFrameworks
//
//  Created by Apple on 2019/11/11.
//  Copyright © 2019 Pxh. All rights reserved.
//

import Foundation
import CommonCrypto
import UIKit

// 枚举
enum CryptoAlgorithm {
    
    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
    
    var MACAligorithm: CCHmacAlgorithm {
     
        var result : Int = 0
        switch self {
        case .MD5:
            result = kCCHmacAlgMD5
        case .SHA1:
            result = kCCHmacAlgSHA1
        case .SHA224:
            result = kCCHmacAlgSHA224
        case .SHA256:
            result = kCCHmacAlgSHA256
        case .SHA384:
            result = kCCHmacAlgSHA384
        case .SHA512:
            result = kCCHmacAlgSHA512
        }
        return CCHmacAlgorithm(result)
    }
    
    var digestLength : Int {
        var result : Int32 = 0
        switch self {
        case .MD5:
            result = CC_MD5_DIGEST_LENGTH
        case .SHA1:
            result = CC_SHA1_DIGEST_LENGTH
        case .SHA224:
            result = CC_SHA224_DIGEST_LENGTH
        case .SHA256:
            result = CC_SHA256_DIGEST_LENGTH
        case .SHA384:
            result = CC_SHA384_DIGEST_LENGTH
        case .SHA512:
            result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
    
    
}


extension String {
    
    /// MD5
    /*
    public var md5: String {
        let utf8 = cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") {$0 + String(format:"%02x", $1)} // 大写 %02X
    }
    */
    // MARK: - 加密
    public var md5: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        return stringFromBytes(bytes: result, length: digestLen)
    }
    
    public var sha1: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA1(str!, strLen, result)
        return stringFromBytes(bytes: result, length: digestLen)
    }
    
    public var sha256String: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_SHA256_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA256(str!, strLen, result)
        return stringFromBytes(bytes: result, length: digestLen)
    }
    
    public var sha512String: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_SHA512_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA512(str!, strLen, result)
        return stringFromBytes(bytes: result, length: digestLen)
    }
    
    func stringFromBytes(bytes: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String{
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", bytes[i])
        }
        bytes.deallocate()
        return String(format: hash as String)
    }
    
    /**复杂的加密
     parama1:上面的枚举值 MD5, SHA1, SHA224, SHA256, SHA384, SHA512
     parama2: 加密的字符串
     
     */
    func hmac(algorithm: CryptoAlgorithm, key: String) -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = Int(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = algorithm.digestLength
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        let keyStr = key.cString(using: String.Encoding.utf8)
        let keyLen = Int(key.lengthOfBytes(using: String.Encoding.utf8))
        CCHmac(algorithm.MACAligorithm, keyStr!, keyLen, str!, strLen, result)
        let digest = stringFromResult(result: result, length: digestLen)
        result.deallocate()
        return digest
    }
    
    private func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash)
    }
    

    
    /// base 64 加密
    ///
    /// - Returns: <#return value description#>
    public func encodeToBase64() -> String {
        guard let data = self.data(using: String.Encoding.utf8) else {
            return ""
        }
        return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }
    
    /// base 64 解密
    ///
    /// - Returns: <#return value description#>
    public func decodeToBase64() -> String {
        guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0)) else {
            return ""
        }
        return String(data: data, encoding: String.Encoding.utf8)!
    }
    
    
    // MARK: -
    /// 动态获取文字宽高
    ///
    /// - Parameters:
    ///   - viewSize: <#viewSize description#>
    ///   - textFont: <#textFont description#>
    /// - Returns: <#return value description#>
    public func boundingSize(_ viewSize: CGSize, textFont: UIFont) -> CGSize {
        let size = self.boundingRect(with: viewSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: textFont], context: nil).size
        return size
    }
    
    
    /// 判断不是空字符串
    ///
    /// 系统判断方法: isEmpty
    /// - Parameter string: <#string description#>
    /// - Returns: true:不是空字符串  false:是空字符串
    public static func isNotEmptyString(_ string: String) -> Bool {
        return !stringIsEmpty(string as AnyObject)
    }
    
    /// 判断空字符串
    ///
    /// 系统判断方法: isEmpty
    /// - Parameter value: <#value description#>
    /// - Returns: true:是空字符串  false:不是空字符串
    public static func stringIsEmpty(_ value: AnyObject?) -> Bool
    {
        // 先判断是否为空
        if nil == value {
            return true
        } else {
            // 是否可转化为字符串
            if let myValue = value as? String {
                // 然后对 String 做判断
                return myValue == "" || myValue == "(null)" || 0 == myValue.count
            } else {
                // 不是字符串，直接认定为空串
                return true
            }
        }
    }
    
    /// 设置行间距
    ///
    /// - Parameters:
    ///   - text: <#text description#>
    ///   - spacing: 大小
    ///   - textSpacing: 字体间距
    /// - Returns: <#return value description#>
    public func setLineSpacing(_ text: String, spacing: CGFloat, textSpacing: CGFloat) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString.init(string: text, attributes: [NSAttributedString.Key.kern: textSpacing])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: text.count))
        return attributedString
    }
    
    /// 截取两个字符间的字符串
    ///
    /// - Parameters:
    ///   - text: 字符串
    ///   - startStr: 开始截取的字符串
    ///   - endStr: 结束的字符串
    /// - Returns: 截取后的字符串
    public static func cutString(_ text: String, startStr: String, endStr: String) -> String {
        let startRange: Range = text.range(of: startStr)!
        let endRange: Range = text.range(of: endStr)!
        let result = text[startRange.upperBound..<endRange.lowerBound]
        return String(result)
    }
    
    /// 从某个字符截取到最后
    ///
    /// - Parameters:
    ///   - text: 字符串
    ///   - startStr: 开始截取的字符串
    ///   - isContain: 是否包含截取的字符
    ///        true: 包含  false: 不包含
    /// - Returns: 截取后的字符串
    public static func cutString(_ text: String, startStr: String, isContain: Bool) -> String {
        let startRange: Range = text.range(of: startStr)!
        if isContain {
            let location = startRange.upperBound
            let suffixStr = text.suffix(from: text.index(before: location))
            return String(suffixStr)
        } else {
            let location = startRange.lowerBound
            let suffixStr = text.suffix(from: text.index(after: location))
            return String(suffixStr)
        }
    }
    
    /// 截取到某个字符
    ///
    /// - Parameters:
    ///   - text: 字符串
    ///   - endStr: 截取到的字符串
    ///   - isContain: 是否包含截取的字符
    ///        true: 包含  false: 不包含
    /// - Returns: 截取后的字符串
    public static func cutString(_ text: String, endStr: String, isContain: Bool) -> String {
        let endRange: Range = text.range(of: endStr)!
        if isContain {
            let location = endRange.upperBound
            let prefixStr = text.prefix(through: text.index(before: location))
            return String(prefixStr)
        } else {
            let location = endRange.upperBound
            let prefixStr = text.prefix(upTo: text.index(before: location))
            return String(prefixStr)
        }
    }
    
    /// 替换字符串中的空格
    ///
    /// - Returns: 替换后的字符串
    public func replaceSpaces() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    /// 银行卡号中间隐藏
    ///
    /// - Returns: 字符串
    public func bankCardDisplayCiphertext() -> String {
        // 获取截取位置
        let fromIndex = self.index(self.startIndex, offsetBy: 4)
         // 截取前4位字符串
        let fromStr = self[self.startIndex..<fromIndex]
        let beforeStr = self.replacingOccurrences(of: fromStr, with: "")
        // 获取后面的截取位置
        let endIndex = self.index(self.endIndex, offsetBy: -4)
        // 截取后4位字符串
        let endStr = self[endIndex..<self.endIndex]
        let afterStr = beforeStr.replacingOccurrences(of: endStr, with: "")
        // 正则替换
        var regular: NSRegularExpression? = nil
        do {
            regular = try NSRegularExpression(pattern: "[a-zA-Z0-9]", options: .caseInsensitive)
        } catch  {
            
        }
        let matchs = regular?.stringByReplacingMatches(in: afterStr, options: .reportProgress, range: NSRange(location: 0, length: afterStr.count), withTemplate: "*")
        let result = fromStr.appending("\( matchs!)\(endStr)")
        return result
    }
    
//    public func translationArabic(_ arabicNum: Int) -> String {
//        let arabicNumStr = String(format: "%ld", Int(arabicNum))
//        let arabicNumeralsAry = ["1","2","3", "4", "5", "6", "7", "8", "9", "0"]
//        let chineseNumeralsAry = ["一","二","三","四","五","六","七","八","九","零"]
//        let digits = ["个","十","百","千","万","十","百","千","亿","十","百","千","兆"]
//        let dictionary = NSDictionary(object: chineseNumeralsAry, forKey: arabicNumeralsAry as NSCopying) as Dictionary
//        if arabicNum < 20 && arabicNum > 9 {
//            if arabicNum == 10 {
//                return "十"
//            } else {
//                let subStr1 = arabicNumStr.suffix(1)
//            }
//        }
//
//        return ""
//    }
//
//
        
}

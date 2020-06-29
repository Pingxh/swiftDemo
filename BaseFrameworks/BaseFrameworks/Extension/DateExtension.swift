//
//  Date+Extension.swift
//  BaseFrameworks
//
//  Created by Apple on 2019/11/13.
//  Copyright © 2019 Pxh. All rights reserved.
//

import Foundation

extension Date {
    
    /// 获取格式化的当前时间
    /// - Parameter formate: 要转换的格式
    public static func formatCurrentTime(formate: String) -> String {
        let formatter = DateFormatter.init()
        formatter.dateFormat = formate
        let timeString = formatter.string(from: Date())
        return timeString
    }
    
    /// 时间转时间戳 10位
    ///
    /// - Parameter dateTime: Date
    /// - Returns: stamp
    
    public static func timeToTimestamp(dateTime: Date) -> String {
        return timeToTimestamp(dateTime: dateTime, isMilli: false)
    }
    
    /// 时间转时间戳 13位
    ///
    /// - Parameters:
    ///   - dateTime: Date
    ///   - isMilli: true 毫秒级  false 秒级
    /// - Returns: stamp
    public static func timeToTimestamp(dateTime: Date, isMilli: Bool) -> String {
        let interval = dateTime.timeIntervalSince1970
        var totalMillSection: Int64
        if !isMilli {
            totalMillSection = CLongLong(interval)
        } else {
            totalMillSection = CLongLong( interval * 1000)
        }
        return String.init(format: "%ld", arguments: [totalMillSection])
    }
    
    
    /// 将Date类型的时间转换为时间戳
    /// - Parameters:
    ///   - date: Date
    ///   - isMilli: true：毫秒级  false：秒级
    public static func dateToTimestamp(_ date: Date, isMilli: Bool) -> String {
        let timeInterval: TimeInterval = date.timeIntervalSince1970
        if isMilli {
            let milliSp = CLongLong(round(timeInterval * 1000))
            return "\(milliSp)"
        } else {
            
            let timeSp = Int(timeInterval)
            return "\(timeSp)"
        }
    }
    
    
    /// 时间戳转为时间
    ///
    /// - Parameters:
    ///   - formatter: 时间格式
    ///   - timeStamp: 时间戳
    /// - Returns: 时间字符串
    public static func timestampToTime(formatter: String, timeStamp: String) -> String {
        let dateFormatte = DateFormatter()
        dateFormatte.dateFormat = formatter
        if timeStamp.count > 10 {
            let interval = Double(timeStamp)!/1000.0
            // string 转 date
            let date = Date.init(timeIntervalSince1970: interval)
            return dateFormatte.string(from: date)
        } else {
            // string 转 date
            let date = Date.init(timeIntervalSince1970: (Double(timeStamp))!)
            return dateFormatte.string(from: date)
        }
    }
    
    /// 根据时间戳字符串返回 几分钟前，几小时前，几天前
    ///
    /// - Parameter timeStamp: String 时间戳字符串
    /// - Returns: 转换后的时间结果
    public static func timestampFromCurrentTime(timeStamp: String) -> String {
        // 当前时间的时间戳
        let currentTime = Date().timeIntervalSince1970
        // 时间差
        var reduceTime: TimeInterval
        if timeStamp.count > 10 {
            reduceTime = currentTime - Double(timeStamp)! / 1000.0
        } else {
            reduceTime = currentTime - Double(timeStamp)!
        }
        // 时间差小于60秒
        if reduceTime < 60 {
            return "刚刚"
        }
        // 时间差大于一分钟，小于60分钟内
        let mins = Int(reduceTime / 60)
        if mins < 60 {
            return "\(mins)分钟前"
        }
        // 时间差大于1小时，小于24小时内
        let hours = Int(reduceTime / 60 / 60)
        if hours < 24 {
            return "\(hours)小时前"
        }
        // 时间差大于1天，小于30天内
        let days = Int(reduceTime / 60 / 60 / 24)
        if days < 30 {
            return "\(days)天前"
        }
        // 不满足以上条件直接返回日期
        let date = Date(timeIntervalSince1970: (Double(timeStamp)!))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    /// 根据时间戳返回 今天HH:mm，昨天HH:mm ...
    ///
    /// - Parameter timeInterval: 时间戳 TimeInterval
    /// - Returns: 结果
    public static func timestampFromCurrentTime(timeInterval: TimeInterval) -> String{
        let timeIntervalStr = String.init(CLongLong(timeInterval))
        var date = Date()
        //如果服务端返回的时间戳精确到毫秒，需要除以1000,否则不需要
        if timeIntervalStr.count == 13 {
            date = getNowDateFromatAnDate(Date(timeIntervalSince1970: timeInterval / 1000.0))
        } else {
            date = getNowDateFromatAnDate(Date(timeIntervalSince1970: timeInterval))
        }
        
        let formatter = DateFormatter()
        
        if date.isToday() {
            //是今天
            formatter.dateFormat = "今天HH:mm"
            return formatter.string(from: date)
        } else if date.isYesterday() {
            //是昨天
            formatter.dateFormat = "昨天HH:mm"
            return formatter.string(from: date)
        } else if date.isSameWeek() {
            //是同一周
            let week = date.weekdayStringFromDate()
            formatter.dateFormat = "\(week)HH:mm"
            return formatter.string(from: date)
        } else {
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            return formatter.string(from: date)
        }
    }
    
    /// 判断是否是今天
    ///
    /// - Returns: <#return value description#>
    func isToday() -> Bool {
        let calendar = Calendar.current
        // 当前时间
        let nowComponents = calendar.dateComponents([.day, .month, .year], from: Date())
        let selfComponents = calendar.dateComponents([.day, .month, .year], from: self)
        return (selfComponents.day == nowComponents.day) && (selfComponents.month == nowComponents.month) && (selfComponents.year == nowComponents.year)
    }
    
    /// 判断是否是昨天
    ///
    /// - Returns: <#return value description#>
    func isYesterday() -> Bool {
        let calendar = Calendar.current
        // 当前时间
        let nowComponents = calendar.dateComponents([.day], from: Date())
        let selfComponents = calendar.dateComponents([.day], from: self)
        let components = calendar.dateComponents([.day], from: selfComponents, to: nowComponents)
        return components.day == 1
    }
    
    /// 判断是否是同一周
    ///
    /// - Returns: <#return value description#>
    func isSameWeek() -> Bool {
        let calendar = Calendar.current
        // 当前时间
        let nowComponents = calendar.dateComponents([.day, .month, .year], from: Date())
        let selfComponents = calendar.dateComponents([.weekday, .month, .year], from: self)
        return (selfComponents.weekday == nowComponents.weekday) && (selfComponents.month == nowComponents.month) && (selfComponents.year == nowComponents.year)
    }
    
    /// 时间戳转星期几
    ///
    /// - Returns: <#return value description#>
    func weekdayStringFromDate() -> String {
        let weekdays: Array = [ "星期六", "星期日", "星期一", "星期二", "星期三", "星期四", "星期五"]
        var calendar = Calendar.init(identifier: .gregorian)
        let timeZone = TimeZone.init(identifier: "Asia/Shanghai")
        calendar.timeZone = timeZone!
        let theComponents = calendar.dateComponents([.weekday], from: self)
        print("\(String(describing: theComponents.weekday))")
        return weekdays[theComponents.weekday!]
    }
    
    public static func getNowDateFromatAnDate(_ anyDate: Date?) -> Date {
        //设置源日期时区
        //        let sourceTimeZone = NSTimeZone(abbreviation: "EST")
        let sourceTimeZone = NSTimeZone(forSecondsFromGMT: +28800)
        //或GMT
        //设置转换后的目标日期时区
        let destinationTimeZone = NSTimeZone.local as NSTimeZone
        //得到源日期与世界标准时间的偏移量
        var sourceGMTOffset: Int? = nil
        if let aDate = anyDate {
            sourceGMTOffset = sourceTimeZone.secondsFromGMT(for: aDate)
        }
        //目标日期与本地时区的偏移量
        var destinationGMTOffset: Int? = nil
        if let aDate = anyDate {
            destinationGMTOffset = destinationTimeZone.secondsFromGMT(for: aDate)
        }
        //得到时间偏移量的差值
        let interval = TimeInterval((destinationGMTOffset ?? 0) - (sourceGMTOffset ?? 0))
        //转为现在时间
        var destinationDateNow: Date? = nil
        if let aDate = anyDate {
            destinationDateNow = Date(timeInterval: interval, since: aDate)
        }
        return destinationDateNow!
    }
    
    
}

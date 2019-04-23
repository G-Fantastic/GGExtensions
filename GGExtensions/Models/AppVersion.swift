//
//  AppVersion.swift
//  weibotest
//
//  Created by gg on 2019/1/12.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

/**
 * 版本错误异常
 */
public enum VersionError: Error {
    case runtimeError(String)
}

/**
 * 用于存储APP版本的类
 */
public class AppVersion: NSObject {
    public var major: Int = 0
    public var minor: Int = 0
    public var third: Int = 0
    

    
    public override init() {
        self.major = 0
        self.minor = 0
        self.third = 0
    }
    
    
    /**
     通过字符串形式的版本号获取AppVersion对象（自动去除字符串中的所有空格以及首尾 . 符号，如果中间存在多个 . 符号相连，只保留一个 . 符号）
     
     ## Example 1:
     ```
     var appVersion = AppVersion()
     do{
        appVersion = try AppVersion("0.0.a")
     }catch VersionError.runtimeError(let errorMsg){
        print(errorMsg)     // 可以打印异常信息
     }catch{}
     ```
     ## Example 2:
     ```
     let appVersion: AppVersion? = try? AppVersion("1.0.1")
     ```
     
     - Parameter from: 字符串版本号
     - Throws: 版本号错误会抛出版本错误的异常：VersionError
    */
    public init(_ source: String) throws {
        let tempSource = source.gg.stringNoSpaceAndHTDot   // 去除所有空格以及首尾 .
        
        /********************************************
         * 再次处理source，若存在中间多个点相连，只保留一个点
         ********************************************/
        var newSource = tempSource.gg.stringReplaceByRegex(pattern: "[.]+", withTemplate: ".")
        let ss = newSource.split(separator: ".")
        
        switch(ss.count){
            case 0:
                newSource = "0.0.0"
            case 1:
                newSource = newSource + ".0.0"
            case 2:
                newSource = newSource + ".0"
            case 3:
                ()  // 空执行
            default:
                throw VersionError.runtimeError("VersionError: 无效的版本号，版本号格式应为：Int.Int.Int，三位必须是Int数值类型，如：1.0.1")
        }
        
//        print(newSource)
        
        let splits: [Int] = try newSource.split(separator: ".").map {
            let e = Int("\($0)")
            guard let i = e else{
                throw VersionError.runtimeError("VersionError: 无效的版本号，版本号格式应为：Int.Int.Int，三位必须是Int数值类型，如：1.0.1")
            }
            return i
        }
        
        self.major = splits[0]
        self.minor = splits[1]
        self.third = splits[2]
    }
    
    public init(_ major: Int, _ minor: Int, _ third: Int) {
        self.major = major
        self.minor = minor
        self.third = third
    }
    
    
    /**
     比较两个AppVersion的大小
     ## Example:
     使用普通的字符串比较版本大小：
     ```
     print("1.0.3".compare("1.0.2").rawValue)    // .orderedDescending: 1    ✔
     print("1.0.3".compare("1.0.20").rawValue)   // .orderedDescending: 1    ✘
     print("1.5.2".compare("1.10.2").rawValue)   // .orderedDescending: 1    ✘
     print("1.01.3".compare("1.1.03").rawValue)  // .orderedAscending: -1    ✘
     print("1.a.2".compare("1.0.1").rawValue)    // .orderedDescending: 1    ✘
     ```
     使用 AppVersion 来比较版本号大小
     ```
     print((try! AppVersion("1.0.3")).compare(try! AppVersion("1.0.2")).rawValue)    // .orderedDescending: 1   ✔
     print((try! AppVersion("1.0.3")).compare(try! AppVersion("1.0.20")).rawValue)   // .orderedAscending: -1   ✔
     print((try! AppVersion("1.5.2")).compare(try! AppVersion("1.10.2")).rawValue)   // .orderedAscending: -1   ✔
     print((try! AppVersion("1.01.3")).compare(try! AppVersion("1.1.03")).rawValue)  // .orderedSame:       0   ✔
     print((try? AppVersion("1.a.2"))?.compare(try! AppVersion("1.0.1")).rawValue)   // nil                     ✔
     
     ```
     可见，普通字符串无法正确比较版本号的大小，必须使用AppVersion才行
    */
    public func compare(_ other: AppVersion) -> ComparisonResult {
        return major == other.major
                ? minor == other.minor
                    ? third.gg.compareInt(other.third)
                    : minor.gg.compareInt(other.minor)
                : major.gg.compareInt(other.major)
    }
    
    /**
     比较两个AppVersion的大小
     
     ## Example:
     ```
     print((try! AppVersion("1.0.3")).compare("1.0.2").rawValue)     // >
     print((try! AppVersion("1.0.3")).compare("1.0.20").rawValue)    // <
     print((try! AppVersion("1.5.2")).compare("1.10.2").rawValue)    // <
     print((try! AppVersion("1.01.3")).compare("1.1.03").rawValue)   // =
     print((try? AppVersion("1.a.2"))?.compare("1.0.1").rawValue)    // nil
     print((try? AppVersion("1.0.2"))!.compare("1.0.a").rawValue)    // Later Invalid
     ```
    */
    public func compare(_ otherVersionStr: String) -> GGComparisonResult {
        let appVersion = try? AppVersion(otherVersionStr)
        
        guard let tempVersion = appVersion else {
            return .laterInvalid
        }
        
        switch compare(tempVersion) {
            case .orderedAscending:
                return .orderedAscending
            case .orderedDescending:
                return .orderedDescending
            default:
                return .orderedSame
        }
        
    }
    
    
    /**
     比较两个AppVersion的大小
     
     ## Example:
     ```
     print(AppVersion.compare("... ..", "").rawValue)                // =
     print(AppVersion.compare("... ..", "1.0.2").rawValue)           // <
     print(AppVersion.compare("1.0. ...   3 ..", "1.0.2").rawValue)  // >
     print(AppVersion.compare("1.0.    3", "1.0.20.  . .").rawValue) // <
     print(AppVersion.compare("1... ..5.2", "1..10.2").rawValue)     // <
     print(AppVersion.compare("1..  ..2", "1..10.2").rawValue)       // <
     print(AppVersion.compare("1... ..5.2", "...1....").rawValue)    // >
     print(AppVersion.compare("1.01  . 3..", "1.1.03").rawValue)     // =
     print(AppVersion.compare("1.a.. .2", "1.0.1").rawValue)         // Prior Invalid
     print(AppVersion.compare("1.0.2", "1.. .0.a").rawValue)         // Later Invalid
     ```
    */
    public class func compare(_ versionStr: String, _ otherVersionStr: String) -> GGComparisonResult {
        
        let appVersion1 = try? AppVersion(versionStr)
        let appVersion2 = try? AppVersion(otherVersionStr)
        
        guard let tempVersion1 = appVersion1 else {
            return .priorInvalid
        }
        guard let tempVersion2 = appVersion2 else {
            return .laterInvalid
        }

        
        switch tempVersion1.compare(tempVersion2) {
        case .orderedAscending:
            return .orderedAscending
        case .orderedDescending:
            return .orderedDescending
        default:
            return .orderedSame
        }
    }
    
    
    
    public override var description: String{
        return "\(major).\(minor).\(third)"
    }
}




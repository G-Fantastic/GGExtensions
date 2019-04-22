//
//  NSDictionary+Extensions.swift
//  weibotest
//
//  Created by mac on 2018/12/24.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation


extension GGReactive where Base : NSDictionary{
    
    /// NSDictionary打印中文，支持NSArray与NSDictionary嵌套
    public var dictionary: /*[AnyHashable : Any]*/[NSObject : Any] {
        return toDictionary()
    }
    
    private func toDictionary() -> [NSObject : Any] {
        var swiftDict: [NSObject : Any] = [:]
        
        if /*self == nil ||*/ base.count == 0{
            return swiftDict
        }else{
            base.forEach { (k, v) in
                /**
                 无法将 k 打印出有 双引号的效果，要达到双引号，必须将 k 转成 Swift的String类型，
                 但由于声明的时候，k 是 NSObject 类型， String不是NSObject类型，无法转换。
                 Any和AnyObject都无法满足字典 key 的要求，因为没有实现 Hashable 协议，要让 key 同时
                 可以接收 String和NSObject ，只能是 AnyHashable，但是这种情况，需要解包，打印的时候，
                 是无法解包的，会打印类似如下结果：AnyHashable("1")，会带有 AnyHashable(...)。
                */
                let key = k as! NSObject
                if v is NSDictionary{
                    let nsDict = v as! NSDictionary
                    swiftDict[key] = nsDict.gg.toDictionary()
                }else if v is NSArray{
                    let nsArr = v as! NSArray
                    swiftDict[key] = nsArr.gg.array
                }else{
                    swiftDict[key] = v
                }
                
            }
            
            return swiftDict
        }
        
    }
    
    
}

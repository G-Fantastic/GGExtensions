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

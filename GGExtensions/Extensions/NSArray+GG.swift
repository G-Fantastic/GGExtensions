//
//  NSArray+Extensions.swift
//  weibotest
//
//  Created by mac on 2018/12/24.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation


extension GGReactive where Base : NSArray{
    
    /// NSArray打印中文，支持NSArray与NSDictionary嵌套
    public var array: [Any]{
        return toArray()
    }
    
    private func toArray() -> [Any] {
        var swiftArr: [Any] = []
        
        if /*self == nil ||*/ base.count == 0{
            return swiftArr
        }else{
            base.forEach {
                if $0 is NSArray{
                    let nsArr = $0 as! NSArray
                    swiftArr.append(nsArr.gg.toArray())
                }else if $0 is NSDictionary{
                    let nsDict = $0 as! NSDictionary
                    swiftArr.append(nsDict.gg.dictionary)
                }else{
                    if $0 is String{
//                        let swiftStr = $0 as! String   // 转成String打印时会带双引号
                        swiftArr.append($0)
                    }else{
                        swiftArr.append($0)
                    }
                    
                }
            }
            
            return swiftArr
        }
    }
    
}

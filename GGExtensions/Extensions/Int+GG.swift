//
//  Int+Extensions.swift
//  weibotest
//
//  Created by gg on 2019/1/12.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

extension GGReactive where Base == Int{
    
    /// 比较两个Int值，返回 ComparisonResult 枚举
    public func compareInt(_ otherInt: Int) -> ComparisonResult {
        
        if base < otherInt{
            return ComparisonResult.orderedAscending
        }else if base == otherInt {
            return ComparisonResult.orderedSame
        }else{
            return ComparisonResult.orderedDescending
        }
    }
}

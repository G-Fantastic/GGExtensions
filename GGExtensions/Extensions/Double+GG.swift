//
//  Double+Extensions.swift
//  weibotest
//
//  Created by mac on 2018/12/20.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation


extension GGReactive where Base == Double{
    
    /// Double保留指定位数，四舍五入
    ///
    /// - Parameter places: 保留几位
    /// - Returns: 返回Double
    public func doubleRoundOff(places: Int) -> Double {
        // 方法一：
        return Double(String(format: "%.\(places)f", base)) ?? 0
        
        // 方法二：
//        let divisor = pow(10.0, Double(places))
//        return (base * divisor).rounded() / divisor
    }
    
    
    
    
    
}



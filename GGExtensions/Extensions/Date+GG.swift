//
//  Date+GG.swift
//  GGExtensions
//
//  Created by mac on 2019/4/22.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

extension GGReactive where Base == Date{
    /// 获取当前时间对象 秒级 时间戳 - 10位
    var secondTimeStamp : Int {
        let timeInterval: TimeInterval = base.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return timeStamp
    }
    
    /// 获取当前时间对象 毫秒级 时间戳 - 13位
    var milliTimeStamp : CLongLong {
        let timeInterval: TimeInterval = base.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return millisecond
    }
    
}

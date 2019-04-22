//
//  File.swift
//  weibotest
//
//  Created by mac on 2019/2/27.
//  Copyright © 2019 mac. All rights reserved.
//

/**
 * 两个对象的比较结果
 */
public enum GGComparisonResult : String {
    case orderedAscending = "<"
    case orderedSame = "="
    case orderedDescending = ">"
    case priorInvalid = "Prior Invalid"
    case laterInvalid = "Later Invalid"
    case invalidComparison = "Invalid Comparison"
}




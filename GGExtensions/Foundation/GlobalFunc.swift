//
//  GlobalFunc.swift
//  GGExtensions
//
//  Created by mac on 2019/3/12.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

/**
 获取对象的类名
 */
internal func ClassName(of value: AnyObject) -> String {
    let subName = NSStringFromClass(type(of: value))
    return subName
}

/**
 * 通过字符串获取对应的类
 */
internal func ClassFromString<T>(_ className: String, _ classType: T.Type) -> T.Type? {
    return NSClassFromString(className) as? T.Type
}


